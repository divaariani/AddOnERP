import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'gudangmobil_view.dart';
import '../utils/globals.dart';

void main() {
  runApp(MaterialApp(
    home: ScanGudangBarangView(),
  ));
}

class ScanGudangBarangView extends StatefulWidget {
  const ScanGudangBarangView({Key? key}) : super(key: key);

  @override
  State<ScanGudangBarangView> createState() => _ScanGudangBarangViewState();
}

class _ScanGudangBarangViewState extends State<ScanGudangBarangView> {
  Future<void> _scanBarcode() async {
    String barcodeGudangBarangResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    String finalGudangBarangResult = '';

    if (barcodeGudangBarangResult.length >= 12) {
      finalGudangBarangResult = barcodeGudangBarangResult.substring(
        barcodeGudangBarangResult.length - 7 - 5, barcodeGudangBarangResult.length - 5
      );
    }

    if (barcodeGudangBarangResult.isNotEmpty) {
      setState(() {
        globalBarcodeBarangResults.add(finalGudangBarangResult);
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GudangMobilView(
            result: '', resultBarangGudang: globalBarcodeBarangResults),
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
            decoration: BoxDecoration(
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
                                builder: (context) => GudangMobilView(
                                    result: '', resultBarangGudang: [''])),
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
                  SizedBox(height: 20),
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
                  Text(
                    textAlign: TextAlign.center,
                    "Scan barcode pada barang!",
                    style: TextStyle(
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
