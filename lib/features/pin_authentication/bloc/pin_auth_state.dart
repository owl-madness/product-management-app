
abstract class PinAuthState {}

// class ShowSnackState extends PinAuthState {
//   String message;
//   ShowSnackState({required this.message });
// }

class PinAuthInitState extends PinAuthState {}

class PinAuthCheckState extends PinAuthState {}

class GeneratePinState extends PinAuthState {}

class ConfirmPinState extends PinAuthState {
  String genPin;
  ConfirmPinState({required this.genPin});
}

class PinLoadingState extends PinAuthState {}

class PinAuthSuccessState extends PinAuthState {}
