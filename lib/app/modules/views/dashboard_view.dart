import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'operatorpresensi_view.dart';
import 'operatorstatus_view.dart';
import 'audit_view.dart';
import 'gudang_view.dart';
import 'home_view.dart';
import 'laporan_view.dart';
import 'monitoring_view.dart';
import '../controllers/login_controller.dart';
import '../controllers/actor_controller.dart';

class DashboardView extends StatefulWidget {
  final String barcodeResult;
  
  const DashboardView({Key? key, required this.barcodeResult}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final LoginController _loginController = Get.find<LoginController>();
  final ActorController _actorController = Get.put(ActorController());
  final BarcodeController _barcodeController = Get.put(BarcodeController());

  @override
  Widget build(BuildContext context) {
    String barcodeResult = _barcodeController.barcodeResult.value;

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
                        Container(
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
                                  backgroundImage: NetworkImage(
                                      _loginController.profilePhotoUrl.value),
                                  radius: 20,
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                "Selamat Bekerja, "+ _loginController.profileName.value + " !",
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 40),
                            ],
                          ),
                        ),
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
                    name: _loginController.profileName.value,
                    id: _loginController.profileId.value,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 1),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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
                          SizedBox(height: 8),
                          Text(
                            'Mesin : $barcodeResult',
                            style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Lokasi : K10',
                            style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        ElevatedButton(
                          onPressed: _actorController.isOperator.value == 't' || _actorController.isAdmin == 't'
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Operator'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OperatorPresensiView()),
                                                  );
                                                },
                                                child: Text('Isi Presensi'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OperatorStatusView()),
                                                  );
                                                },
                                                child: Text('Status Mesin'),
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
                                width: 52,
                                height: 52,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Monitoring Produksi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isOperator.value == 't' || _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isAuditor.value == 't' || _actorController.isAdmin == 't'
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
                                width: 52,
                                height: 52,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Audit',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _actorController.isAuditor.value == 't' || _actorController.isAdmin == 't'
                                          ? Color(0xFF226EA4)
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed:
                              _actorController.isWarehouse.value == 't' || _actorController.isAdmin == 't'
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
                                width: 52,
                                height: 52,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Warehouse',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isWarehouse.value == 't' || _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isQC.value == 't' || _actorController.isAdmin == 't'
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
                                width: 52,
                                height: 52,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Laporan Produksi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isQC.value == 't' || _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isCustomer.value == 't' || _actorController.isAdmin == 't'
                              ? () {
                                  // Get.to(() => CustomerView());
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
                                width: 52,
                                height: 52,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Customer Tracker',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _actorController.isCustomer.value == 't' || _actorController.isAdmin == 't'
                                      ? Color(0xFF226EA4)
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _actorController.isMonitor.value == 't' || _actorController.isAdmin == 't'
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
                                width: 52,
                                height: 52,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Monitoring',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _actorController.isMonitor.value == 't' || _actorController.isAdmin == 't'
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
  final String name;
  final String id;
  const CardID({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      margin: EdgeInsets.symmetric(horizontal: 20),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: $id',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF226EA4),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OperatorPresensiView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF226EA4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      side: BorderSide.none,
                    ),
                    shadowColor: Color(0x3F000000),
                    elevation: 4,
                  ),
                  child: Container(
                    width: 88,
                    height: 35,
                    alignment: Alignment.center,
                    child: Text(
                      "Isi Presensi",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF226EA4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}