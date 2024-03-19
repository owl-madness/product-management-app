import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:product_management/features/pin_authentication/bloc/pin_auth_event.dart';
import 'package:product_management/features/pin_authentication/bloc/pin_auth_state.dart';
import 'package:product_management/utilities/appconfigs.dart';
import 'package:product_management/utilities/secure_storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinAuthBloc extends Bloc<PinAuthEvent, PinAuthState> {
  PinAuthBloc() : super(PinAuthInitState()) {
    on<CheckPinAuthAvail>((event, emit) async {
      final pref = await SharedPreferences.getInstance();
      bool? isPinGenerated = pref.getBool(AppConfig.isPinGeneratedKey);
      print('isPinGenerated $isPinGenerated');
      if (isPinGenerated ?? false) {
        emit(PinAuthCheckState());
      } else {
        emit(GeneratePinState());
      }
    });

    on<InitPinGenerationEvent>((event, emit) {
      if (event.genPin.length == 4) {
        emit(ConfirmPinState(genPin: event.genPin));
      } else {
        Fluttertoast.showToast(msg: 'Enter 4 numbers');
        // emit(ShowSnackState(message: 'Enter 4 numbers'));
      }
    });

    on<ConfirmPinEvent>((event, emit) async {
      if (event.genPin.trim() != event.cfPin.trim()) {
        Fluttertoast.showToast(msg: 'Pin does not matching');
      } else {
        final pref = await SharedPreferences.getInstance();
        
        SecureStorageHelper secureStorageHelper = SecureStorageHelper();
        secureStorageHelper.storePin( event.genPin.trim());
        pref.setBool(AppConfig.isPinGeneratedKey, true);
        emit(PinAuthCheckState());
      }
    });

    on<AuthenticatePinEvent>((event, emit) async {
      if (event.enteredPin.length != 4) {
        Fluttertoast.showToast(msg: 'Enter correct pin');
      } else {
        // emit(PinLoadingState());
        SecureStorageHelper secureStorageHelper = SecureStorageHelper();
        String pinValue = await secureStorageHelper.getPin() ?? '';
        if (pinValue.trim() != event.enteredPin.trim()) {
          Fluttertoast.showToast(msg: 'Enter correct pin');
        } else {
          emit(PinAuthSuccessState());
          Navigator.pushNamedAndRemoveUntil(event.context, '/home', (route) => false);
        }
      }
    });
  }
}
