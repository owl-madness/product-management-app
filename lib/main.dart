import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/authentication/signin/signin_bloc.dart';
import 'package:product_management/features/authentication/signup/signup_bloc.dart';
import 'package:product_management/features/authentication/splash/splash_bloc.dart';
import 'package:product_management/features/authentication/ui/signin_screen.dart';
import 'package:product_management/features/authentication/ui/signup_screen.dart';
import 'package:product_management/features/authentication/ui/splash_screen.dart';
import 'package:product_management/features/home/bloc/home_bloc.dart';
import 'package:product_management/features/home/ui/home_screen.dart';
import 'package:product_management/features/pin_authentication/bloc/pin_auth_bloc.dart';
import 'package:product_management/features/pin_authentication/ui/pin_auth_screen.dart';
import 'package:product_management/features/product_details/ui/product_details_screen.dart';
import 'package:product_management/utilities/secure_storage/secure_storage_bloc.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (_) => SignInBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (_) => SignUpBloc(),
        ),
        BlocProvider<SplashBloc>(
          create: (_) => SplashBloc(),
        ),
        BlocProvider<PinAuthBloc>(
          create: (_) => PinAuthBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<SecureStorageBloc>(
          create: (_) => SecureStorageBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Product Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/signin': (context) => SignInScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
          '/pin-auth': (context) => PinAuthScreen(),
          '/product-details': (context) => ProductDetailsScreen(),
        },
      ),
    );
  }
}
