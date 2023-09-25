import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../utils/sessionmanager.dart';
import '../controllers/actor_controller.dart';
import '../controllers/auditor_controller.dart';
import '../controllers/response_model.dart';
import 'audit_view.dart';

void main() {
  runApp(MaterialApp(
    home: AuditIsiView(),
  ));
}

class AuditIsiView extends StatefulWidget {
  const AuditIsiView({Key? key}) : super(key: key);

  @override
  State<AuditIsiView> createState() => _AuditIsiViewState();
}

class _AuditIsiViewState extends State<AuditIsiView> {
  late DateTime currentTime;
  final ActorController _actorController = Get.put(ActorController());
  final idController = TextEditingController();
  final nameController = TextEditingController();

  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userName = "";
  String userIdLogin = "";

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _fetchCurrentTime();
  }

  Future<void> _fetchUserId() async {
    userName = await _sessionManager.getUsername() ?? "";
    userIdLogin = await _sessionManager.getUserId() ?? "";
    setState(() {});
  }

  Future<void> _fetchCurrentTime() async {
    try {
      setState(() {
        currentTime = DateTime.now();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _submitAuditor() async {
    final int id = int.parse(userIdLogin);
    final String name = 'Auditor_' +
        userName +
        "_" +
        DateFormat('ddMMyyyy').format(DateTime.now());

    try {
      await _fetchCurrentTime();

      ResponseModel response = await AuditorController.postFormData(
        userid: id,
        name: name,
        date: currentTime,
      );

      if (response.status == 1) {
        Get.snackbar('Auditor Berhasil Presensi', 'Congratulations');
      } else if (response.status == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request gagal: ${response.message}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: Response tidak valid.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuditView()),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    child: Container(
                      width: 1 * MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Nama: ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue[900],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Auditor_' +
                                      userName +
                                      "_" +
                                      DateFormat('ddMMyyyy')
                                          .format(DateTime.now()),
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue[900],
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text("Date: ",
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                                Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text("Department: ",
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                                Text(
                                    _actorController.isOperator.value == 't'
                                        ? 'Operator'
                                        : _actorController.isAdmin.value == 't'
                                            ? 'Administrator'
                                            : _actorController
                                                        .isAuditor.value ==
                                                    't'
                                                ? 'Auditor'
                                                : _actorController.isWarehouse
                                                            .value ==
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
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _submitAuditor();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuditView(),
                              ),
                            );
                          },
                          icon: Icon(Icons.save_alt, size: 20),
                          label: Text('Simpan', style: TextStyle(fontSize: 14)),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(8, 77, 136, 136),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            minimumSize: Size(120, 60),
                          ),
                        ),
                      ],
                    ),
                  ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Color(0xFF2A77AC),
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuditView()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: Text(
                  "Audit Stock",
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
      ),
    );
  }
}
