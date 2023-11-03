import 'package:addon/app/modules/views/gudangout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../utils/globals.dart';
import 'gudangmobil_view.dart';

void main() {
  runApp(const MaterialApp(
    home: ScanGudangView(),
  ));
}

class ScanGudangView extends StatefulWidget {
  const ScanGudangView({Key? key}) : super(key: key);

  @override
  State<ScanGudangView> createState() => _ScanGudangViewState();
}

class _ScanGudangViewState extends State<ScanGudangView> {
  String _barcodeGudangResult = 'Scan barcode pada mobil!';

  Future<void> _scanBarcode() async {
    String barcodeGudangResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    setState(() {
      _barcodeGudangResult = barcodeGudangResult;
    });

    setGlobalBarcodeMobilResult(barcodeGudangResult);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GudangMobilView(result: barcodeGudangResult, resultBarangGudang: []),
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
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GudangOutView()),
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
                            "Scan Mobil",
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
                            color:const Color(0xFF084D88),
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
                                  primary: const Color(0xFF226EA4),
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
                  Text(
                    textAlign: TextAlign.center, 
                    "$_barcodeGudangResult",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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
