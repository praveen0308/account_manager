import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'backup_restore_state.dart';

class BackupRestoreCubit extends Cubit<BackupRestoreState> {
  BackupRestoreCubit() : super(BackupRestoreInitial());
}
