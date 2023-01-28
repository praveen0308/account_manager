import 'package:account_manager/local/db_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../../network/google_drive_app_data.dart';
import 'package:googleapis/drive/v3.dart' as drive;

part 'backup_restore_state.dart';

class BackupRestoreCubit extends Cubit<BackupRestoreState> {
  BackupRestoreCubit() : super(BackupRestoreInitial());
  final GoogleDriveAppData _googleDriveAppData = GoogleDriveAppData();

  GoogleSignInAccount? _googleUser;
  drive.DriveApi? _driveApi;

  Future<void> initUI() async {
    emit(LoadingUI());
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        var status = await _googleDriveAppData.checkUserSignIn();
        if (status) {
          emit(UserSignedIn());
        } else {
          emit(NoUserSignedIn());
        }
      } catch (e) {
        emit(Error("Something went wrong!!!"));
        debugPrint("Error : ${e.toString()}");
      }
    } else {
      emit(NoInternet());
      debugPrint('No internet :(');
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SigningIn());
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      try {
        _googleUser = await _googleDriveAppData.signInGoogle();

        if (_googleUser != null) {
          _driveApi = await _googleDriveAppData.getDriveApi(_googleUser!);
          emit(UserSignedIn());
        } else {
          emit(NoUserSignedIn());
        }
      } catch (e) {
        emit(Error("Something went wrong!!!"));
        debugPrint("Error : ${e.toString()}");
      }
    } else {
      emit(NoInternet());
      debugPrint('No internet :(');
    }
  }

  Future<void> signOut() async {
    await _googleDriveAppData.signOut();
    _googleUser = null;
    _driveApi = null;
    emit(NoUserSignedIn());
  }

  Future<void> loadBackups() async {
    emit(LoadingBackupHistory());
    _googleUser = await _googleDriveAppData.signInGoogle();
    _driveApi = await _googleDriveAppData.getDriveApi(_googleUser!);
    var fileList = await _googleDriveAppData.showList(driveApi: _driveApi!);

    var files = fileList?.files ?? [];

    if (files.isEmpty) {
      emit(NoBackupFound());
    } else {
      emit(ReceivedBackupVersions(files.first));
    }
  }

  Future<void> backupNow() async {
    emit(BackingUp());
    var dbFile = await DatabaseHelper.getCurrentDB();
    await _googleDriveAppData.uploadDriveFile(driveApi: _driveApi!, file: dbFile);
    emit(BackupSuccessful());
    await Future.delayed(const Duration(milliseconds: 300));
    loadBackups();
  }

  Future<void> restoreBackup() async {
    emit(Restoring());
    var fileList = await _googleDriveAppData.showList(driveApi: _driveApi!);

    var files = fileList?.files ?? [];
    if (files.isEmpty) {
      emit(NoBackupForRestoration());
    } else {
      var remoteDb = files.first;
      String dbPath = await getDatabasesPath();
      String targetLocalPath  = "$dbPath/accountManager.db";

      try{
        await _googleDriveAppData.restoreDriveFile(driveApi: _driveApi!, driveFile: remoteDb, targetLocalPath: targetLocalPath);
        emit(RestoreSuccessful());
      }catch(e){
        emit(RestorationFailed());
      }
    }
  }
}
