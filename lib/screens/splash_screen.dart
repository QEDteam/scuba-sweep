import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/utilities/router.dart';

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

    Future.delayed(const Duration(seconds: 1)).then((value) async {
      ref.read(routerProvider).go("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 65, 152, 251),
      body: Center(
        child: SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
