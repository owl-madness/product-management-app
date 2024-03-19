import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/authentication/authentication_helper.dart';
import 'package:product_management/features/authentication/signin/signin_event.dart';
import 'package:product_management/features/authentication/signin/signin_state.dart';
import 'package:product_management/utilities/appconfigs.dart';
import 'package:product_management/utilities/secure_storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationHelper _authHelper = AuthenticationHelper();

  SignInBloc() : super(SignInInitState()) {
    on<SignInButtonPressed>((event, emit) async {
      emit(SigningInState());
      final result = await _authHelper.signIn(
          email: event.email, password: event.password);
      if (result == null) {
        final pref = await SharedPreferences.getInstance();
        SecureStorageHelper secureStorageHelper = SecureStorageHelper();
        secureStorageHelper.storeCredentials(event.email);
        pref.setBool(AppConfig.loggedStateKey, true);
        AppConfig.userID = event.email;
        emit(SignedInState());
      } else {
         emit(SignInErrorState(result));
      }
    });
  }

  // @override
  // Stream<SignInState> mapEventToState(SignInEvent event) async* {
  //   if (event is SignInButtonPressed) {
  //     yield SigningInState();
  //     try {
  //       final result = await _authHelper.signIn(email: event.email, password: event.password);
  //       if (result == null) {
  //         yield SignedInState();
  //       } else {
  //         yield SignInErrorState(result);
  //       }
  //     } catch (e) {
  //       yield SignInErrorState('An error occurred');
  //     }
  //   }
  // }
}
