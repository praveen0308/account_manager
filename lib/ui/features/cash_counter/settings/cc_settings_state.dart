part of 'cc_settings_cubit.dart';

@immutable
abstract class CcSettingsState {}

class CcSettingsInitial extends CcSettingsState {}
class Loading extends CcSettingsState {}
class Error extends CcSettingsState {}
class ReceivedCurrencies extends CcSettingsState {

  final List<Currency> currencies;

  ReceivedCurrencies(this.currencies);
}
class UpdatedSuccess extends CcSettingsState {}
