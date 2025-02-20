import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../generator/assets.gen.dart';

class FlavorConfig {
  static final FlavorConfig _singleton = FlavorConfig._internal();

  factory FlavorConfig() {
    return _singleton;
  }

  FlavorConfig._internal();

  String buildFlavor = "";

  bool get isMock {
    return buildFlavor == AppFlavor.mock.name;
  }

  bool get isNonProd {
    return buildFlavor != AppFlavor.prod.name;
  }

  Future getFlavorSettings() async {
    const methodChannel = MethodChannel('flavor');
    buildFlavor = await methodChannel.invokeMethod('flavor');
  }

  AppFlavor getFlavor() {
    switch (buildFlavor) {
      case "prod":
        return AppFlavor.prod;
      default:
        return AppFlavor.mock;
    }
  }

  Future loadEnv() async {
    if (buildFlavor == AppFlavor.prod.name) {
      await dotenv.load(fileName: Assets.aEnvProd);
    } else {
      await dotenv.load(fileName: Assets.aEnvMock);
    }
  }
}

enum AppFlavor {
  mock("mock"),
  prod("prod");

  final String name;

  const AppFlavor(this.name);
}
