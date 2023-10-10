import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../utils/sessionmanager.dart';
import '../controllers/actor_controller.dart';
import '../controllers/auditor_controller.dart';
import '../controllers/response_model.dart';
import '../controllers/notification_controller.dart';
import 'audit_view.dart';
import 'refresh_view.dart';

class AuditIsiView extends StatefulWidget {
  const AuditIsiView({Key? key}) : super(key: key);

  @override
  State<AuditIsiView> createState() => _AuditIsiViewState();
}

class _AuditIsiViewState extends State<AuditIsiView> {
  late DateTime currentTime;
  final ActorController _actorController = Get.put(ActorController());
  final SessionManager sessionManager = SessionManager();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  String userName = "";
  String userIdLogin = "";

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _fetchCurrentTime();
  }

  Future<void> _fetchUserId() async {
    userName = await sessionManager.getUsername() ?? "";
    userIdLogin = await sessionManager.getUserId() ?? "";
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

  Future<void> _submitNotif() async {
    final int id = int.parse(userIdLogin);
    final String title = 'Presensi';
    final String description = 'Anda berhasil melakukan presensi audit';
    final String date = DateFormat('yyyy-MM-dd HH:mm').format(currentTime);

    try {
      await _fetchCurrentTime();

      ResponseModel response = await NotificationController.postNotification(
        userid: id,
        title: title,
        description: description,
        date: date,
      );

      if (response.status == 1) {
        print('notification insert success');
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

  Future<void> _submitAuditor() async {
    final int id = int.parse(userIdLogin);
    final String name = 'Auditor_$userName' + "_" + DateFormat('ddMMyyyy').format(DateTime.now());

    try {
      await _fetchCurrentTime();

      ResponseModel response = await AuditorController.postFormData(
        userid: id,
        name: name,
        date: currentTime,
      );

      if (response.status == 1) {
        Get.snackbar('Auditor Berhasil Presensi', 'Congratulations');
        _submitNotif();
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
          MaterialPageRoute(builder: (context) => const AuditView()),
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
                    const SizedBox(height: 70),
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
                                    'Auditor_$userName' + "_" + DateFormat('ddMMyyyy').format(DateTime.now()),
                                    style: GoogleFonts.poppins(
                                      color: Colors.blue[900],
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text("Date: ",
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      )),
                                  Text(
                                      DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text("Department: ",
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      )),
                                  Text(
                                      _actorController.isAdmin.value == 't'
                                          ? 'Administrator'
                                          : _actorController.isAuditor.value == 't'
                                              ? 'Auditor'
                                              : 'Unknown Staff',
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      )
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                                  builder: (context) => RefreshAuditor(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.save_alt, size: 20),
                            label: const Text('Simpan',
                                style: TextStyle(fontSize: 14)),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(8, 77, 136, 136),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                              minimumSize: const Size(120, 60),
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
                backgroundColor: const Color(0xFF2A77AC),
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuditView()),
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
