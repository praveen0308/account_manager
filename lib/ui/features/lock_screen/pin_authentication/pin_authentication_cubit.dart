import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pin_authentication_state.dart';

class PinAuthenticationCubit extends Cubit<PinAuthenticationState> {
  PinAuthenticationCubit() : super(PinAuthenticationInitial());
}
