part of 'gst_calculator_cubit.dart';

@immutable
abstract class GstCalculatorState {}

class GstCalculatorInitial extends GstCalculatorState {}
class EvaluationPerformed extends GstCalculatorState {
  final String expression;
  final String answer;

  EvaluationPerformed(this.expression, this.answer);
}
