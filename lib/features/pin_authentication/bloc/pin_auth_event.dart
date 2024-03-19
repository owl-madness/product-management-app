import 'package:flutter/material.dart';

abstract class PinAuthEvent {}

class CheckPinAuthAvail extends PinAuthEvent {}

class InitPinGenerationEvent extends PinAuthEvent {
  String genPin;
  InitPinGenerationEvent({required this.genPin});
}

class ConfirmPinEvent extends PinAuthEvent {
  String cfPin;
  String genPin;
  ConfirmPinEvent({required this.cfPin, required this.genPin});
  }

class AuthenticatePinEvent extends PinAuthEvent {
  String enteredPin;
  BuildContext context;
  AuthenticatePinEvent({required this.context, required this.enteredPin});
}