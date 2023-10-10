import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'auditlokasi_view.dart';
import '../utils/globals.dart';

class ScanAuditBarangView extends StatefulWidget {
  const ScanAuditBarangView({Key? key}) : super(key: key);

  @override
  State<ScanAuditBarangView> createState() => _ScanAuditBarangViewState();
}

class _ScanAuditBarangViewState extends State<ScanAuditBarangView> {
  Future<void> _scanBarcode() async {
    String barcodeAuditBarangResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    // String finalAuditBarangResult = '';

    // if (barcodeAuditBarangResult.length >= 12) {
    //   finalAuditBarangResult = barcodeAuditBarangResult.substring(
    //     barcodeAuditBarangResult.length - 7 - 5, barcodeAuditBarangResult.length - 5
    //   );
    // }

    if (barcodeAuditBarangResult.isNotEmpty) {
      setState(() {
        globalBarcodeBarangResults.add(barcodeAuditBarangResult);
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuditLokasiView(
            result: '', resultBarang: globalBarcodeBarangResults),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AuditLokasiView(result: '', resultBarang: const [''])),
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
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF084D88),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Image(
                                  image: AssetImage("assets/icon.barcode.png"),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton.icon(
                                  onPressed: _scanBarcode,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Image.asset(
                                      'assets/icon.scan.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                  ),
                                  label: const Text('Scan QR Code',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF084D88),
                                    onPrimary: Colors.white,
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
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Scan barcode pada Barang!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
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
                          builder: (context) =>
                              AuditLokasiView(result: '', resultBarang: const [''])),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: const Text(
                  "Scan Barang",
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
