import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/pin_authentication/bloc/pin_auth_bloc.dart';
import 'package:product_management/features/pin_authentication/bloc/pin_auth_event.dart';
import 'package:product_management/features/pin_authentication/bloc/pin_auth_state.dart';

class PinAuthScreen extends StatefulWidget {
  const PinAuthScreen({super.key});

  @override
  State<PinAuthScreen> createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends State<PinAuthScreen> {
  late final PinAuthBloc pinBloc;
  late String generatedPin;
  late String confirmPin;
  late String enteredPin;
  final pinTextController = TextEditingController();

  @override
  void initState() {
    pinBloc = BlocProvider.of<PinAuthBloc>(context);
    pinBloc.add(CheckPinAuthAvail());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: BlocConsumer<PinAuthBloc, PinAuthState>(
              listener: (context, state) {
                if (state is PinAuthCheckState) {
                  pinTextController.clear();
                }
                if (state is PinAuthSuccessState) {
                  pinTextController.clear();
                }
                if (state is ConfirmPinState) {
                  pinTextController.clear();
                }
              },
              builder: (context, state) {
                print('state is $state');
                if (state is PinAuthInitState || state is PinLoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is PinAuthCheckState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter PIN to Login',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      TextField(
                        controller: pinTextController,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(letterSpacing: 30),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            hintText: 'Enter PIN',
                            hintStyle: TextStyle(letterSpacing: 5)),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => enteredPin = value,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: () => pinBloc.add(AuthenticatePinEvent(
                              context: context, enteredPin: enteredPin)),
                          child: const Text('Done')),
                    ],
                  );
                }
                if (state is GeneratePinState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter to generate your new PIN ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      TextField(
                        controller: pinTextController,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(letterSpacing: 30),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            hintText: 'Enter new PIN',
                            hintStyle: TextStyle(letterSpacing: 5)),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => generatedPin = value,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: () => pinBloc.add(
                              InitPinGenerationEvent(genPin: generatedPin)),
                          child: const Text('Generate Pin'))
                    ],
                  );
                }
                if (state is ConfirmPinState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Re-enter your PIN to generate ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      TextField(
                        controller: pinTextController,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(letterSpacing: 30),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            hintText: 'Re-enter PIN',
                            hintStyle: TextStyle(letterSpacing: 5)),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) => confirmPin = value,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: () => pinBloc.add(ConfirmPinEvent(
                              cfPin: confirmPin, genPin: generatedPin)),
                          child: const Text('Confirm'))
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
