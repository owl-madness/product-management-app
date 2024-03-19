import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/authentication/splash/splash_bloc.dart';
import 'package:product_management/features/authentication/splash/splash_event.dart';
import 'package:product_management/features/authentication/splash/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashBloc = BlocProvider.of<SplashBloc>(context);

    splashBloc.add(CheckLoggedState());

    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is UserLoggedInState) {
            Navigator.pushNamedAndRemoveUntil(context,'/pin-auth', (route) => false);
          } else if (state is UserNotLoggedInState) {
            Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
