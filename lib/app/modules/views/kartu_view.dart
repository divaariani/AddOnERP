import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/actor_controller.dart';
import 'home_view.dart';

class KartuView extends StatefulWidget {
  const KartuView({Key? key}) : super(key: key);

  @override
  State<KartuView> createState() => _KartuViewState();
}

class _KartuViewState extends State<KartuView> {
  final LoginController _loginController = Get.find<LoginController>();
  final ActorController _actorController = Get.put(ActorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
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
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        },
                        child: Image.asset('assets/icon.back.png',
                            width: 60, height: 60),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Kartu Pekerja",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 230,
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 1),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(150, 49, 105, 189)!,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Container(
                                    height: 64,
                                    width: 64,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(_loginController
                                            .profilePhotoUrl.value),
                                      ),
                                      borderRadius: BorderRadius.circular(64),
                                      border: Border.all(
                                        color: Colors.blue[900]!,
                                        style: BorderStyle.solid,
                                        width: 4,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'ID: ' + _loginController.profileId.value,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  _loginController.profileName.value,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Departemen',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
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
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
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
