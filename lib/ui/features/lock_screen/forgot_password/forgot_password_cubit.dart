import 'package:account_manager/local/secure_storage.dart';
import 'package:account_manager/models/pair.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());
  final SecureStorage _storage = SecureStorage();

  Future<void> loadQuestions()async {
    emit(Loading());

    final List<Pair<String, String>> questions = await _storage.getQuestions();

    emit(ReceivedQuestions(questions));
  }
}
