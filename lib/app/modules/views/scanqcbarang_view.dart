import 'package:addon/app/modules/views/laporantambah_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../utils/globals.dart';

void main() {
  runApp(const MaterialApp(
    home: ScanQcBarangView(),
  ));
}

class ScanQcBarangView extends StatefulWidget {
  final String? date;

  const ScanQcBarangView({ this.date, Key? key}) : super(key: key);

  @override
  State<ScanQcBarangView> createState() => _ScanQcBarangViewState();
}

class _ScanQcBarangViewState extends State<ScanQcBarangView> {
  DateTime? _selectedDay;
  String _userIdLogin = "";
  final _createTglController = TextEditingController();

  Future<void> _scanBarcode() async {
    DateTime? previousSelectedDay = _selectedDay;
    String previousUserIdLogin = _userIdLogin;
    String previousCreateTgl = _createTglController.text;
    String barcodeQcBarangResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    //String finalQcBarangResult = '';

    // if (barcodeQcBarangResult.length >= 12) {
    //   finalQcBarangResult = barcodeQcBarangResult.substring(
    //     barcodeQcBarangResult.length - 7 - 5, barcodeQcBarangResult.length - 5
    //   );
    // }

    if (barcodeQcBarangResult.isNotEmpty) {
      setState(() {
        globalBarcodeBarangQcResults.add(barcodeQcBarangResult);
      });
    }

    setState(() {
      _selectedDay = previousSelectedDay;
      _userIdLogin = previousUserIdLogin;
      _createTglController.text = previousCreateTgl;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LaporanTambahView(
            result: '', resultBarangQc: globalBarcodeBarangQcResults),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                begin: Alignment(0.99, -0.14),
                end: Alignment(-0.99, 0.14),
                colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LaporanTambahView(
                                    result: '', resultBarangQc: [''])),
                          );
                        },
                        child: Image.asset('assets/icon.back.png',
                            width: 60, height: 60),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Scan Barang",
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
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
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
                              ElevatedButton(
                                onPressed: _scanBarcode,
                                style: ElevatedButton.styleFrom(
                                  primary:const Color(0xFF226EA4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Row(
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
                  const Text(
                    textAlign: TextAlign.center,
                    "Scan barcode pada barang!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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
