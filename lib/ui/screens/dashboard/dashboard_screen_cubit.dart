import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_screen_state.dart';

class DashboardScreenCubit extends Cubit<DashboardScreenState> {
  DashboardScreenCubit() : super(DashboardScreenInitial());
}
