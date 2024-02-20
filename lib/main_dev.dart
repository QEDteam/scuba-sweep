import 'package:my_flutter_app/flavor_config.dart';
import 'package:my_flutter_app/main_common.dart';
import 'firebase_options_dev.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    env: "dev",
    name: "DEV myApp",
    values: FlavorValues(
        bundleID: 'myApp.com.dev',
        appID: '',
        baseUrl: '',
        apiUrl: '',
        sentryUrl: '',
        dynamicLinkUrl: ''),
  );

  mainCommon(DefaultFirebaseOptions.currentPlatform);
}
