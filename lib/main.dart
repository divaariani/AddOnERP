import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/splash.dart';
import 'app/modules/utils/sessionmanager.dart';
import 'app/modules/controllers/login_controller.dart';
import 'app/modules/controllers/actor_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sessionManager = SessionManager();
  await sessionManager.initPrefs();
  final isLoggedIn = await sessionManager.isLoggedIn();
  Get.put(LoginController());
  Get.put(ActorController()); 
  runApp(AddOnApp(isLoggedIn: isLoggedIn));
}

class AddOnApp extends StatelessWidget {
  final bool isLoggedIn;

  const AddOnApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Sutrado Add On",
              theme: ThemeData(
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              initialRoute: Routes.HOME,
              getPages: AppPages.routes,
            );
          }
        },
      );
    } else {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sutrado Add On",
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: Routes.LOGIN,
        getPages: AppPages.routes,
      );
    }
  }
}
