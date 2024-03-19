import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/authentication/authentication_helper.dart';
import 'package:product_management/features/authentication/signup/signup_event.dart';
import 'package:product_management/features/authentication/signup/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationHelper _authHelper = AuthenticationHelper();

  SignUpBloc() : super(SignUpInitState()){
    on<SignUpButtonPressed>((event, emit) async {
      emit(SigningUpState());
      final result = await _authHelper.signUp(email: event.email, password: event.password);
        if (result == null) {
          emit(SignedUpState());
        } else {
          ScaffoldMessenger.of(event.context)
                .showSnackBar(SnackBar(content: Text(result)));
        }
    });
  }

  // @override
  // Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
  //   if (event is SignUpButtonPressed) {
  //     yield SigningUpState();
  //     try {
  //       final result = await _authHelper.signUp(email: event.email, password: event.password);
  //       if (result == null) {
  //         yield SignedUpState();
  //       } else {
  //         yield SignUpErrorState(result, error: 'error');
  //       }
  //     } catch (e) {
  //       yield SignUpErrorState('result',error: 'An error occurred');
  //     }
  //   }
  // }
}
