import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/auth_provider.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/flavor_banner.dart';
import 'package:scuba_sweep/game/game/overlay_widgets/overlay_frame.dart';
import 'package:scuba_sweep/game/helper/colors.dart';
import 'package:scuba_sweep/game/helper/enums.dart';
import 'package:scuba_sweep/game/helper/styles.dart';
import 'package:scuba_sweep/screens/widgets/action_button.dart';
import 'package:scuba_sweep/screens/widgets/text_input_field.dart';
import 'package:scuba_sweep/utilities/router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController nicknameController = TextEditingController();

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
        backgroundColor: AppColors.primaryDark,
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: OverlayFrame(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'welcome.title',
                    style: titleTextStyle,
                  ).tr(),
                  const SizedBox(height: 20),
                  Text(
                    'welcome.message',
                    textAlign: TextAlign.start,
                    style: subtitleStyle,
                  ).tr(),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: PlasticType.values
                        .map(
                          (e) => Image.asset(
                            'assets/images/${e.imagePath}',
                            height: 50,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextInputField(
                    controller: nicknameController,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: state.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : ActionButton(
                            title: "NEXT",
                            onPressed: () => state.isLoading
                                ? null
                                : ref
                                    .read(signInProvider.notifier)
                                    .signInAnonymously()
                                    .then(
                                      (value) => ref
                                          .read(scoreNotifierProvider.notifier)
                                          .setNickname(nicknameController.text),
                                    ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
