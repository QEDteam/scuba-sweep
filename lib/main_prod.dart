import 'package:my_flutter_app/firebase_options_prod.dart';
import 'package:my_flutter_app/flavor_config.dart';
import 'package:my_flutter_app/main_common.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.prod,
    env: "prod",
    name: "myApp",
    values: FlavorValues(
        bundleID: 'myApp.com',
        appID: '',
        baseUrl: '',
        apiUrl: '',
        sentryUrl: '',
        dynamicLinkUrl: ''),
  );

  mainCommon(DefaultFirebaseOptions.currentPlatform);
}
