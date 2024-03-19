import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/authentication/signin/signin_bloc.dart';
import 'package:product_management/features/authentication/signin/signin_event.dart';
import 'package:product_management/features/authentication/signin/signin_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInBloc = BlocProvider.of<SignInBloc>(context);

    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignedInState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed in successfully')));
                Navigator.pushNamedAndRemoveUntil(context, '/pin-auth', (route) => false);
          }
          if (state is SignInErrorState) {
            ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is SigningInState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: state.emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.email),
                      label: Text('Email'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: state.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.lock),
                      label: Text('Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signInBloc.add(SignInButtonPressed(
                          email: state.emailController.text.trim(),
                          password: state.passwordController.text.trim()));
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('Create account'),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
