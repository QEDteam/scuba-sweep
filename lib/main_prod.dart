import 'package:scuba_sweep/firebase_options_prod.dart';
import 'package:scuba_sweep/flavor_config.dart';
import 'package:scuba_sweep/main_common.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.prod,
    env: "prod",
    name: "scuba_sweep",
    values: FlavorValues(
        bundleID: 'io.qedcode.scubasweep',
        appID: '',
        baseUrl: '',
        apiUrl: '',
        sentryUrl: '',
        dynamicLinkUrl: ''),
  );

  mainCommon(DefaultFirebaseOptions.currentPlatform);
}
