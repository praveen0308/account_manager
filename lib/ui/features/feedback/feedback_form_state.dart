part of 'feedback_form_cubit.dart';

@immutable
abstract class FeedbackFormState {}

class FeedbackFormInitial extends FeedbackFormState {}
class Loading extends FeedbackFormState {}
class SubmittedSuccessfully extends FeedbackFormState {}
class Error extends FeedbackFormState {
  final String msg;

  Error(this.msg);

}
