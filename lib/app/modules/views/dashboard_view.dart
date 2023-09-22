import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'scanoperator_view.dart';
import 'operatorstatus_view.dart';
import 'audit_view.dart';
import 'gudang_view.dart';
import 'laporan_view.dart';
import 'monitoring_view.dart';
import 'customer_view.dart';
import 'operatormonitoring_view.dart';
import '../controllers/actor_controller.dart';
import '../controllers/audituser_controller.dart';
import '../utils/globals.dart';
import '../utils/sessionmanager.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DateTime currentTime;
  late String formattedDate;
  final ActorController _actorController = Get.put(ActorController());
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  final nameController = TextEditingController();

  String userId = "";
  String userName = "";
  String userPhoto = "";
  String nameInventory = '';

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

  Future<void> _fetchUserId() async {
    userId = await _sessionManager.getUserId() ?? "";
    userName = await _sessionManager.getUsername() ?? "";
    userPhoto = await _sessionManager.getUserProfile() ?? "";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _fetchCurrentTime();
    AuditUserController auditUserController = Get.put(AuditUserController());

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
    String barcodeResult = globalBarcodeResult;

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
                  Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      color: Colors.blue[900]!,
                                      style: BorderStyle.solid,
                                      width: 4,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(userPhoto),
                                    radius: 20,
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      "Selamat Bekerja !",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            // Get.to(() => NotificationsView());
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CardID(
                    name: userName,
                    id: userId,
                    mesin: (_actorController.isOperator.value == 't' ||
                            _actorController.isAdmin == 't')
                        ? (barcodeResult.isNotEmpty
                            ? '[$barcodeResult]'
                            : '[Kode Mesin]')
                        : '',
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        ElevatedButton(
                          onPressed: _actorController.isOperator.value == 't' ||
                                  _actorController.isAdmin == 't'
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Color(0xFFFAFAFA),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: Color(0xFF084D88),
                                              width: 2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Color(0xFF084D88),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScanOperatorView(),
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icon.presensi.png',
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Isi Presensi',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                height: 50,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Color(0xFF084D88),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OperatorStatusView(),
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icon.mesin.png',
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Status Mesin',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                height: 50,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Color(0xFF084D88),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OperatorMonitorView(),
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icon.monitoring.png',
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'Production Monitoring',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) {
                                    if (value != null) {
                                      print(value);
                                    }
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.operator.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Monitoring Produksi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isOperator.value ==
                                              't' ||
                                          _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isAuditor.value == 't' ||
                                  _actorController.isAdmin == 't'
                              ? () {
                                  Get.to(() => AuditView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.audit.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Audit',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _actorController.isAuditor.value == 't' ||
                                              _actorController.isAdmin == 't'
                                          ? Color(0xFF226EA4)
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed:
                              _actorController.isWarehouse.value == 't' ||
                                      _actorController.isAdmin == 't'
                                  ? () {
                                      Get.to(() => GudangView());
                                    }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.gudang.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Gudang',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isWarehouse.value ==
                                              't' ||
                                          _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isQC.value == 't' ||
                                  _actorController.isAdmin == 't'
                              ? () {
                                  Get.to(() => LaporanView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.qc.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Laporan Produksi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isQC.value == 't' ||
                                          _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isCustomer.value == 't' ||
                                  _actorController.isAdmin == 't'
                              ? () {
                                  Get.to(() => CustomerView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.tracker.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Customer Tracker',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isCustomer.value ==
                                              't' ||
                                          _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isMonitor.value == 't' ||
                                  _actorController.isAdmin == 't'
                              ? () {
                                  Get.to(() => MonitoringView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.monitor.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Monitoring',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _actorController.isMonitor.value == 't' ||
                                              _actorController.isAdmin == 't'
                                          ? Color(0xFF226EA4)
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardID extends StatelessWidget {
  final String id;
  final String name;
  final String mesin;
  const CardID({required this.id, required this.name, required this.mesin});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          color: Color.fromARGB(255, 255, 255, 255),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: $id",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF226EA4),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF226EA4),
                      ),
                    ),
                    Spacer(),
                    Text(
                      mesin,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
