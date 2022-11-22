import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'custom_emi_calculator_state.dart';

class CustomEmiCalculatorCubit extends Cubit<CustomEmiCalculatorState> {
  CustomEmiCalculatorCubit() : super(CustomEmiCalculatorInitial());
}
