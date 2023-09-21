import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'operatorpresensi_view.dart';
import 'scanoperator_view.dart';
import 'notification_view.dart';
import 'profile_view.dart';
import 'dashboard_view.dart';
import '../utils/sessionmanager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();

  int _currentIndex = 0;
  final List<Widget> _pages = [
    DashboardView(),
    OperatorPresensiView(barcodeResult: ''),
    ScanOperatorView(),
    NotificationView(),
    ProfileView(),
  ];

  DateTime? currentBackPressTime;

  void checkInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar('No Internet Connection', 'Please check your internet connection.', duration: Duration(seconds: 5));
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
                      Duration(seconds: 2)) {
                currentBackPressTime = DateTime.now();

                Get.snackbar("Press twice to exit","Klik dua kali untuk keluar aplikasi", duration: Duration(seconds: 2));

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
          backgroundColor: Colors.transparent,
          bottomNavigationBar: CurvedNavigationBar(
            index: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Color(0xFFC5D7E4),
            color: Color(0xFFC5D7E4),
            animationDuration: Duration(milliseconds: 300),
            items: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  SizedBox(height: 4),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up),
                  SizedBox(height: 4),
                  Text(
                    'Activity',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner),
                  SizedBox(height: 4),
                  Text(
                    'QR Code',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(height: 4),
                  Text(
                    'Notifs',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(height: 4),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              _pages[_currentIndex],
            ],
          ),
        ));
  }
}
