import 'package:flutter/material.dart';

abstract class SignInState {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
}

class SignInInitState extends SignInState {}

class SigningInState extends SignInState {}

class SignedInState extends SignInState {}

class SignInErrorState extends SignInState {
  final String error;

  SignInErrorState(this.error);
}
