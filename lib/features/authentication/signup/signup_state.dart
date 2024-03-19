import 'package:flutter/material.dart';

abstract class SignUpState {}

class SignUpInitState extends SignUpState {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cfpasswordController = TextEditingController();
}

class SigningUpState extends SignUpState {}

class SignedUpState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState(String result, {required this.error});
}
