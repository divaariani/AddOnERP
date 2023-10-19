import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'scanaudit_view.dart';
import 'home_view.dart';
import 'audithasil_view.dart';
import 'auditisi_view.dart';
import '../controllers/audit_controller.dart';
import '../utils/sessionmanager.dart';
import '../utils/app_colors.dart';

class AuditView extends StatefulWidget {
  const AuditView({Key? key}) : super(key: key);
  @override
  State<AuditView> createState() => _AuditViewState();
}

class _AuditViewState extends State<AuditView> {
  final nameController = TextEditingController();
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  late DateTime currentTime;
  late String formattedDate;
  bool isLoading = false;

  String userName = "";
  String nameInventory = '';

  Future<void> _fetchUserId() async {
    userName = await _sessionManager.getUsername() ?? "";
    setState(() {});
  }

  Future<void> _fetchCurrentTime() async {
    try {
      setState(() {
        currentTime = DateTime.now();
        formattedDate = DateFormat('ddMMyyyy').format(currentTime);
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _fetchCurrentTime();
    AuditController auditUserController = Get.put(AuditController());

    loadNameInventory().then((value) {
      setState(() {
        nameInventory = value ?? '';
        nameController.text = nameInventory;
      });
    }).catchError((error) {
      print(error);
    });

    auditUserController.fetchNameInventory().then((name) {
      setState(() {
        nameInventory = name;
        nameController.text = nameInventory;
      });
    }).catchError((error) {
      print(error);
    });
  }

  Future<String?> loadNameInventory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nameInventory');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            
            Container(
              width: 360,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.blueTwo, AppColors.blueThree],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: CustomButton(
                                text: "Auditor",
                                isActive: true,
                                targetPage: const AuditView(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: CustomButton(
                                text: "Stock",
                                isActive: false,
                                targetPage: const AuditHasilView(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<String>(
                      future: Future.delayed(const Duration(seconds: 1), () {
                        return nameController.text !=
                                "Auditor_$userName" "_$formattedDate"
                            ? "-"
                            : nameController.text;
                      }),
                      builder: (context, snapshot) {
                        return Stack(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 26),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          'User: ',
                                          style: GoogleFonts.poppins(
                                            color: AppColors.blueOne,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data ?? "",
                                          style: GoogleFonts.poppins(
                                            color: AppColors.blueOne,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: nameController.text !=
                                    "Auditor_$userName" "_$formattedDate"
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AuditIsiView()),
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.person_outline, size: 15),
                            label: const Text('Isi Auditor',
                                style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.blueOne,
                              onPrimary: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                              minimumSize: const Size(130, 48),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: nameController.text ==
                                    "Auditor_$userName" "_$formattedDate"
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScanAuditView()),
                                    );
                                  }
                                : null,
                            icon: const Icon(Icons.qr_code_scanner, size: 15),
                            label: const Text('Scan Lokasi',
                                style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.blueOne,
                              onPrimary: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                              minimumSize: const Size(130, 48),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: AppColors.blueTwo,
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: const Text(
                  "Audit Stock",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final Widget targetPage;

  CustomButton(
      {required this.text, required this.isActive, required this.targetPage});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isCurrentPage = false;

  @override
  void initState() {
    super.initState();
    isCurrentPage = widget.targetPage.runtimeType == AuditView;
  }

  void _navigateToTargetPage() {
    if (!isCurrentPage) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              widget.targetPage,
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToTargetPage,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isActive
                ? [
                    AppColors.white,
                    AppColors.blueOne
                  ]
                : [
                    AppColors.white,
                    AppColors.blueThree
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: widget.isActive
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.isActive
                ? AppColors.white
                : AppColors.blueOne,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
