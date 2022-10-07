part of 'cash_calculator_view_cubit.dart';

@immutable
abstract class CashCalculatorViewState {}

class CashCalculatorViewInitial extends CashCalculatorViewState {}
class Loading extends CashCalculatorViewState {}
class Error extends CashCalculatorViewState {}
class Clear extends CashCalculatorViewState {}
class ReceivedCurrencies extends CashCalculatorViewState {
  final List<Currency> currencies;

  ReceivedCurrencies(this.currencies);
}
