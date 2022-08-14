import 'package:dyeus/src/pages/home/home_screen.dart';
import 'package:dyeus/src/pages/login/login.dart';
import 'package:dyeus/src/pages/login/login_bindings.dart';
import 'package:dyeus/src/pages/otp/otp_binding.dart';
import 'package:dyeus/src/pages/otp/otp_screen.dart';
import 'package:get/get.dart';

abstract class RouteName {
  static String login = "/login";
  static String otp = "/otp";
  static String home = "/home";
}

abstract class AppPages {
  static List<GetPage> get getPages => [
        GetPage(
          name: RouteName.login,
          binding: LoginBinding(),
          page: () => const LoginPage(),
        ),
        GetPage(
          name: RouteName.otp,
          binding: OtpBinding(),
          page: () => const OtpPage(),
        ),
        GetPage(
          name: RouteName.home,
          // binding: OtpBinding(),
          page: () => const HomeScreen(),
        ),
      ];
}
