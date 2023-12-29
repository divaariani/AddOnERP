import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'notification_view.dart';
import 'profile_view.dart';
import 'dashboard_view.dart';
import '../utils/sessionmanager.dart';
import '../utils/app_colors.dart';
import '../controllers/actor_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ActorController controller = Get.put(ActorController());
  var _currentIndex = 0;
  DateTime? currentBackPressTime;
  
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  final List<Widget> _pages = [
    const DashboardView(),
    const NotificationView(),
    const ProfileView(),
  ];

  void checkInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar(
          'No Internet Connection', 'Please check your internet connection.',
          duration: const Duration(seconds: 5));
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
            return false;
          } else {
            bool isLoggedIn = await _sessionManager.isLoggedIn();
            if (isLoggedIn) {
              if (currentBackPressTime == null ||
                  DateTime.now().difference(currentBackPressTime!) >
                      const Duration(seconds: 2)) {
                currentBackPressTime = DateTime.now();

                Get.snackbar("Press twice to exit",
                    "Klik dua kali untuk keluar aplikasi",
                    duration: const Duration(seconds: 2));

                return false;
              } else {
                exit(0);
              }
            } else {
              return true;
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(5),
            child: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              items: [
                SalomonBottomBarItem(
                  icon: Image.asset("assets/icon.home.png", width: 24, height: 24),
                  title: const Text("Beranda"),
                  selectedColor: AppColors.blueTwo,
                ),
                SalomonBottomBarItem(
                  icon: Image.asset("assets/icon.bell.png", width: 24, height: 24),
                  title: const Text("Notifikasi"),
                  selectedColor: AppColors.blueTwo,
                ),
                SalomonBottomBarItem(
                  icon: Image.asset("assets/icon.person.png", width: 24, height: 24),
                  title: const Text("Profile"),
                  selectedColor: AppColors.blueTwo,
                ),
              ],
            ),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              _pages[_currentIndex],
              Visibility(
                visible: controller.loading.value,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
            ],
          ),
        )
      );
  }
}
