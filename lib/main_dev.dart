import 'package:scuba_sweep/flavor_config.dart';
import 'package:scuba_sweep/main_common.dart';
import 'firebase_options_dev.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    env: "dev",
    name: "DEV scuba_sweep",
    values: FlavorValues(
        bundleID: 'io.qedcode.scubasweep.dev',
        appID: '',
        baseUrl: '',
        apiUrl: '',
        sentryUrl: '',
        dynamicLinkUrl: ''),
  );

  mainCommon(DefaultFirebaseOptions.currentPlatform);
}
