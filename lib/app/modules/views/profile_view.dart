import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/actor_controller.dart';
import '../controllers/login_controller.dart';
import '../utils/sessionmanager.dart';
import '../utils/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ActorController _actorController = Get.put(ActorController());
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();

  String userLogin = "";
  String userName = "";
  String userProfile = "";

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    userLogin = await _sessionManager.getUserId() ?? "";
    userName = await _sessionManager.getUsername() ?? "";
    userProfile = await _sessionManager.getUserProfile() ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bgscreen.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Profile",
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
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(userProfile),
                                  ),
                                  borderRadius: BorderRadius.circular(64),
                                  border: Border.all(
                                    color: AppColors.blueOne,
                                    style: BorderStyle.solid,
                                    width: 4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: $userLogin',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.blueOne,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  userName,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.blueOne,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Departemen',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.blueOne,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _actorController.isOperator.value == 't'
                                      ? 'Operator'
                                      : _actorController.isAdmin.value == 't'
                                          ? 'Administrator'
                                          : _actorController.isAuditor.value ==
                                                  't'
                                              ? 'Auditor'
                                              : _actorController
                                                          .isWarehouse.value ==
                                                      't'
                                                  ? 'Staff Gudang'
                                                  : _actorController
                                                              .isQC.value ==
                                                          't'
                                                      ? 'Staff Laporan Produksi'
                                                      : _actorController
                                                                  .isCustomer
                                                                  .value ==
                                                              't'
                                                          ? 'Customer'
                                                          : 'Unknown Staff',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.blueOne,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.blueOne,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          child: Image.asset(
                                              'assets/icon.calendar.png'),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text("Kehadiran",
                                            style: TextStyle(fontSize: 16, color: AppColors.white)),
                                      ],
                                    ),
                                    const Text(
                                      "90%",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 40),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 8),
                                    Column(
                                      children: [
                                        Text("Hadir",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.white)),
                                        SizedBox(height: 10),
                                        Text("9",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Tidak Hadir",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.white)),
                                        SizedBox(height: 10),
                                        Text("-",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.white)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("Izin",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.white)),
                                        SizedBox(height: 10),
                                        Text("1",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.white)),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20,
                                            bottom: 10,
                                            left: 16,
                                            right: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Apakah Anda ingin keluar akun ?',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: AppColors.blueOne,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:AppColors.greyThree,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Batalkan',
                                                    style: TextStyle(
                                                      color: AppColors.blueOne,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Get.find<LoginController>().logout();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.blueOne,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Ya',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Container(
                                height: 25,
                                width: 25,
                                child: Image.asset('assets/icon.out.png'),
                              ),
                              label: const Text('Keluar'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.blueOne,
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
