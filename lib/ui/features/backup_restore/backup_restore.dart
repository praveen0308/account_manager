import 'dart:io';

import 'package:account_manager/utils/toaster.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../network/google_drive.dart';
import '../../../res/app_colors.dart';

class BackupNRestoreScreen extends StatefulWidget {
  const BackupNRestoreScreen({Key? key}) : super(key: key);

  @override
  State<BackupNRestoreScreen> createState() => _BackupNRestoreScreenState();
}

class _BackupNRestoreScreenState extends State<BackupNRestoreScreen> {

  final GoogleDrive _gDrive =  GoogleDrive();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text("Backup and Restore"),),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Icon(Icons.backup_outlined),
                Text("No bakups found!!")
              ],
            ),
          ),
          Positioned(bottom: 0,left: 0,right: 0,child: Row(

            children: [
              Expanded(
                child: ElevatedButton(onPressed: () async {
                  final dbFolder = await getDatabasesPath();
                  File source1 = File('$dbFolder/accountManager.db');
                  _gDrive.uploadFileToGoogleDrive(source1).then((value) => showToast("Uploaded successfully!!",ToastType.success));
                }, child: Text("Backup")),
              )
            ],
          ))
        ],
      ),

    ));
  }
}
