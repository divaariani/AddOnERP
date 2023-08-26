library addon.globals;
import '../controllers/login_controller.dart';
import 'package:get/get.dart';

final LoginController _loginController = Get.find<LoginController>();

String globalID = _loginController.profileId.value;