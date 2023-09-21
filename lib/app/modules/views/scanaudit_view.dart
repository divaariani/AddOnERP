import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../utils/globals.dart';
import 'audit_view.dart';
import 'auditlokasi_view.dart';

void main() {
  runApp(MaterialApp(
    home: ScanAuditView(),
  ));
}

class ScanAuditView extends StatefulWidget {
  const ScanAuditView({Key? key}) : super(key: key);

  @override
  State<ScanAuditView> createState() => _ScanAuditViewState();
}

class _ScanAuditViewState extends State<ScanAuditView> {
  String _barcodeAuditResult = '';

  Future<void> _scanBarcode() async {
    String barcodeAuditResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    setState(() {
      _barcodeAuditResult = barcodeAuditResult;
    });

    setGlobalBarcodeLokasiResult(barcodeAuditResult);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AuditLokasiView(result: barcodeAuditResult, resultBarang: []),
      ),
    );
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
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF084D88),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage("assets/icon.barcode.png"),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _scanBarcode,
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF226EA4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.qr_code,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Scan QR Code",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Scan barcode pada lokasi!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
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
                  "Scan Lokasi",
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
