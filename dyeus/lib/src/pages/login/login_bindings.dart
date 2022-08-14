import 'package:dyeus/src/pages/login/data/login_repo_impl.dart';
import 'package:dyeus/src/pages/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => LoginRepoImpl());
    Get.lazyPut(() => LoginController());
  }
}
