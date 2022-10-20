part of 'cc_settings_cubit.dart';

@immutable
abstract class CcSettingsState {}

class CcSettingsInitial extends CcSettingsState {}
class Loading extends CcSettingsState {}
class Error extends CcSettingsState {}
class UpdatedSuccessfully extends CcSettingsState {}
class ReceivedNotes extends CcSettingsState {

  final List<Currency> currencies;

  ReceivedNotes(this.currencies);
}

