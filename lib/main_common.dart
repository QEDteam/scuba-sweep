import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:scuba_sweep/data/providers/auth_provider.dart';
import 'package:scuba_sweep/data/providers/theme_provider.dart';
import 'package:scuba_sweep/services/push_notif_service.dart';
import 'package:scuba_sweep/utilities/router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:scuba_sweep/utilities/theme.dart';

import 'data/envied/env.dart';

void mainCommon(options) async {
  OpenAI.apiKey = Env.openaiApiKey;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: options,
  );
  // ignore: unused_local_variable
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  /* final pushNotifService = PushNotificationsService();

  if (Platform.isIOS) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      await pushNotifService.registerNotification();
    });
  } else {
    await pushNotifService.registerNotification();
  } */

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final container = ProviderContainer();

  await container.read(authStateChangesProvider.future);
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: UncontrolledProviderScope(
          container: container, child: const ScubaSweep())));
}

void configLoading() {}

class ScubaSweep extends ConsumerStatefulWidget {
  const ScubaSweep({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ScubaSweepState();
}

class ScubaSweepState extends ConsumerState<ScubaSweep> {
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = FpTheme.of(context).darkTone60
      ..backgroundColor = Colors.grey[50]
      ..contentPadding = const EdgeInsets.all(25)
      ..maskColor = Colors.transparent
      ..progressColor = FpTheme.of(context).darkTone60
      ..indicatorColor = FpTheme.of(context).darkTone60
      ..indicatorType = EasyLoadingIndicatorType.wave;

    final router = ref.watch(routerProvider);
    ThemeMode themeMode = ref.watch(themeProvider).mode;

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode,
      routerConfig: router,
      builder: EasyLoading.init(builder: (context, child) {
        //EasyLoading.init();
        // Obtain the current media query information.
        final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(
          // Set the default textScaleFactor to 1.0 for
          // the whole subtree.
          data:
              mediaQueryData.copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      }),
    );
  }
}
