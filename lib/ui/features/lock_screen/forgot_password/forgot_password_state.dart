part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}
class Loading extends ForgotPasswordState {}
class ReceivedQuestions extends ForgotPasswordState {
  final List<Pair<String,String>> questions;

  ReceivedQuestions(this.questions);
}
