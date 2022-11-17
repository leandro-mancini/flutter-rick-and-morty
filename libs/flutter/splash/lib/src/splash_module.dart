import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_splash/src/splash_page.dart';

class SplashModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => const SplashPage()),
  ];
}