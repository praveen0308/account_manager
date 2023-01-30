import 'package:account_manager/local/secure_storage.dart';
import 'package:account_manager/models/pair.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'remember_password_state.dart';

class RememberPasswordCubit extends Cubit<RememberPasswordState> {
  RememberPasswordCubit() : super(RememberPasswordInitial());
  final SecureStorage _storage = SecureStorage();


  Future<void> saveQNA(List qNAPairs) async {
    emit(Loading());
    int qN = 0;

    for (Pair<String, String> p in qNAPairs) {
      await _storage.saveQuestion(qN, p.first, p.second);
      qN++;
    }

    emit(SavedSuccessfully());
  }
}
