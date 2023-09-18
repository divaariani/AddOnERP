import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../utils/sessionmanager.dart';
import '../utils/globals.dart';
import '../controllers/actor_controller.dart';
import '../controllers/auditor_controller.dart';
import '../controllers/response_model.dart';
import 'audit_view.dart';

void main() {
  runApp(MaterialApp(
    home: AuditIsiView(onSaveText: (String textToSave) {
      print('Saved: $textToSave');
    }),
  ));
}

class AuditIsiView extends StatefulWidget {
  final ValueChanged<String> onSaveText;

  const AuditIsiView({Key? key, required this.onSaveText}) : super(key: key);

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
    currentNameAuditor = name;

    try {
      await _fetchCurrentTime();

      ResponseModel response = await AuditorController.postFormData(
        userid: id,
        name: name,
        date: currentTime,
      );

      if (response.status == 1) {
        Get.snackbar('AUDITOR PRESENT SUCCESSFUL', 'Congratulations');
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
                            MaterialPageRoute(
                                builder: (context) => AuditView()),
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
                            "Isi Auditor",
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
                  SizedBox(height: 20),
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
                            String textToSave = 'Auditor_' +
                                userName +
                                "_" +
                                DateFormat('ddMMyyyy').format(DateTime.now());
                            widget.onSaveText(textToSave);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuditView(),
                                settings: RouteSettings(arguments: textToSave),
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
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
