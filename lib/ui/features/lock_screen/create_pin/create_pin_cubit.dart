import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_pin_state.dart';

class CreatePinCubit extends Cubit<CreatePinState> {
  CreatePinCubit() : super(CreatePinInitial());
}
