import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scuba_sweep/data/providers/score_provider.dart';
import 'package:scuba_sweep/game/helper/colors.dart';
import 'package:scuba_sweep/utilities/router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initSystem();
  }

  initSystem() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    // Get any initial links
    PendingDynamicLinkData? initialLink = await dynamicLinks.getInitialLink();

    if (initialLink != null) {
      inspect(initialLink);
      // handle redirect route if needed
    }

    dynamicLinks.onLink.listen((dynamicLinkData) async {
      // handle redirect route if needed
      inspect(dynamicLinkData);
    }).onError((error) {
      // Handle errors
    });

    Future.delayed(const Duration(seconds: 2)).then((value) async {
      ref.read(scoreNotifierProvider.notifier).getNickname();
      ref.read(routerProvider).go("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 300,
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              width: 300,
              child: LinearProgressIndicator(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
