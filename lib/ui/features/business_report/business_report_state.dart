part of 'business_report_cubit.dart';

@immutable
abstract class BusinessReportState {}

class BusinessReportInitial extends BusinessReportState {}

class Loading extends BusinessReportState {}

class Error extends BusinessReportState {
  final String msg;

  Error(this.msg);
}

class NoTransactions extends BusinessReportState {}

class ReceivedTransactions extends BusinessReportState {
  final List<CDTransaction> transactions;

  ReceivedTransactions(this.transactions);
}
