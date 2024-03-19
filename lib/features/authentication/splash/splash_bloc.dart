import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/authentication/authentication_helper.dart';
import 'package:product_management/features/authentication/splash/splash_event.dart';
import 'package:product_management/features/authentication/splash/splash_state.dart';
import 'package:product_management/utilities/appconfigs.dart';
import 'package:product_management/utilities/secure_storage_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthenticationHelper _authHelper = AuthenticationHelper();

  SplashBloc() : super(UserNotLoggedInState()) {
    on<CheckLoggedState>((event, emit) async {
      final isLoggedIn = await _authHelper.isUserLoggedIn();
      if (isLoggedIn) {
         SecureStorageHelper secureStorageHelper = SecureStorageHelper();
        AppConfig.userID = await secureStorageHelper.getCredentials();
        emit(UserLoggedInState());
      } else {
        emit(UserNotLoggedInState());
      }
    });
  }
}
