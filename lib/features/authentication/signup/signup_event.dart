
import 'package:flutter/material.dart';

abstract class SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignUpButtonPressed(this.context, {required this.email, required this.password});
}

