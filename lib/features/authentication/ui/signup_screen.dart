import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/authentication/signup/signup_bloc.dart';
import 'package:product_management/features/authentication/signup/signup_event.dart';
import 'package:product_management/features/authentication/signup/signup_state.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if(state is SignedUpState){
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Signed up successfully')));
            Navigator.pop(context);
          } else if (state is SignUpErrorState) {
              ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is SigningUpState) {
            return const Center(child: CircularProgressIndicator());
          } else if(state is SignUpInitState){
           final initState = state as SignUpInitState;
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign up',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller:initState. emailController,
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
                    controller:initState. passwordController,
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
                  TextFormField(
                    controller:initState. cfpasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefix: Icon(Icons.lock),
                      label: Text('Confirm Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (initState.passwordController.text.trim() !=
                          initState.cfpasswordController.text.trim()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Passwords not matching')));
                      } else {
                        signUpBloc.add(SignUpButtonPressed(
                          context,
                            email:initState. emailController.text.trim(),
                            password:initState. passwordController.text.trim()));
                      }
                    },
                    child: const Text('Create account'),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            );
          } else {
            return const Center(child: Text("Something went wrong"),);
          }
        },
      ),
    );
  }
}
