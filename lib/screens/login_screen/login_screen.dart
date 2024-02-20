import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/data/providers/auth_provider.dart';
import 'package:my_flutter_app/flavor_banner.dart';
import 'package:my_flutter_app/utilities/router.dart';
import 'package:my_flutter_app/widgets/fp_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  static const Key anonymousButtonKey = Key('anonymus');

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  void getInfo() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'Login Screen seen',
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      signInProvider,
      (_, state) => (state is AsyncError)
          ? log('Error')
          : ref.read(routerProvider).go("/home/game"),
    );
    final state = ref.watch(signInProvider);

    return FlavorBanner(
      child: Scaffold(
        backgroundColor: Colors.indigo[800],
        body: Center(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Aqua Quest',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextInputField(
                    controller: emailController,
                    hintText: tr("Email"),
                  ),
                  TextInputField(
                    controller: passwordController,
                    hintText: tr("Password"),
                    obsecureText: true,
                  ),
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: TextButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () => ref
                                        .read(signInProvider.notifier)
                                        .signInWithEmailAndPassword(
                                          emailController.text,
                                          passwordController.text,
                                        ),
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            FpButton(
                              key: anonymousButtonKey,
                              title: tr("Skip Login"),
                              onPressed: state.isLoading
                                  ? null
                                  : () => ref
                                      .read(signInProvider.notifier)
                                      .signInAnonymously(),
                              isLoading: state.isLoading,
                            ),
                          ],
                        )
                  //const SocialLogin()
                ],
              ),
            ),
          ),
        )), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obsecureText = false});
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: obsecureText,
        decoration: InputDecoration(
          focusColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
