part of 'backup_restore_cubit.dart';

@immutable
abstract class BackupRestoreState {}

class BackupRestoreInitial extends BackupRestoreState {}
class LoadingBackupHistory extends BackupRestoreState {}
class SigningIn extends BackupRestoreState {}
class LoadingUI extends BackupRestoreState {}
class NoInternet extends BackupRestoreState {}
class NoUserSignedIn extends BackupRestoreState {}
class UserSignedIn extends BackupRestoreState {}
class Error extends BackupRestoreState {
  final String msg;
  Error(this.msg);
}
class NoBackupFound extends BackupRestoreState {}
class ReceivedBackupVersions extends BackupRestoreState {
  final drive.File file;
  ReceivedBackupVersions(this.file);
}

class BackingUp extends BackupRestoreState {}
class BackupSuccessful extends BackupRestoreState {}
class BackupFailed extends BackupRestoreState {}

class Restoring extends BackupRestoreState {}
class NoBackupForRestoration extends BackupRestoreState {}
class RestoreSuccessful extends BackupRestoreState {}
class RestorationFailed extends BackupRestoreState {}
