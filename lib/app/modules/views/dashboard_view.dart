import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'scanoperator_view.dart';
import 'operatorstatus_view.dart';
import 'audit_view.dart';
import 'gudanghasil_view.dart';
import 'laporanhasil_view.dart';
import 'monitoringhasil_view.dart';
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
    String barcodeResult = globalBarcodeMesinResult;

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
                    padding: const EdgeInsets.only(top: 32, left: 16, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
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
                                      color: const Color(0xFF084D88),
                                      style: BorderStyle.solid,
                                      width: 4,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(userPhoto),
                                    radius: 20,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        "Selamat Bekerja, $userName !",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: const Color(0xFF084D88),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                  const SizedBox(height: 20),
                  Center(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      children: [
                        ElevatedButton(
                          onPressed: _actorController.isOperator.value == 't' ||
                                  _actorController.isAdmin == 't'
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: const Color(0xFFFAFAFA),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
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
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: const Color(0xFF084D88),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                          const ScanOperatorView(),
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
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        'Isi Presensi',
                                                        style: TextStyle(
                                                            color:Color(0xFFFAFAFA)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
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
                                                            const OperatorStatusView(),
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icon.mesin.png',
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        'Status Mesin',
                                                        style: TextStyle(
                                                          color: Color(0xFFFAFAFA),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                height: 50,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: const Color(0xFF084D88),
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
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icon.monitoring.png',
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      const Text(
                                                        'Production Monitoring',
                                                        style: TextStyle(
                                                          color: Color(0xFFFAFAFA),
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
                            primary: const Color(0xFFFAFAFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.operator.png',
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Produksi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isOperator.value ==
                                              't' ||
                                          _actorController.isAdmin == 't'
                                      ? const Color(0xFF226EA4)
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
                                  Get.to(() => const AuditView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFAFAFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.audit.png',
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Audit',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _actorController.isAuditor.value == 't' ||
                                              _actorController.isAdmin == 't'
                                          ? const Color(0xFF226EA4)
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
                                      Get.to(() => const GudangHasilView());
                                    }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFAFAFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.gudang.png',
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Gudang',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isWarehouse.value == 't' || _actorController.isAdmin == 't'
                                      ? const Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isQC.value == 't' || _actorController.isAdmin == 't'
                              ? () {
                                  Get.to(() => const LaporanHasilView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFAFAFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.qc.png',
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Laporan Produksi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isQC.value == 't' ||
                                          _actorController.isAdmin == 't'
                                      ? const Color(0xFF226EA4)
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
                                  Get.to(() => const MonitoringHasilView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFAFAFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.monitor.png',
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Monitoring',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isMonitor.value == 't' || _actorController.isAdmin == 't'
                                          ? const Color(0xFF226EA4)
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
                                  Get.to(() => const CustomerView());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFAFAFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon.tracker.png',
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Customer',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isCustomer.value ==
                                              't' ||
                                          _actorController.isAdmin == 't'
                                      ? const Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
  const CardID({Key? key, required this.id, required this.name, required this.mesin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          color: const Color(0xFFFAFAFA),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: $id",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF226EA4),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF226EA4),
                      ),
                    ),
                    Spacer(),
                    Text(
                      mesin,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF226EA4),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      );
  }
}
