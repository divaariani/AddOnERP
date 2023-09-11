import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'home_view.dart';
import 'operatorpresensi_view.dart';
import '../utils/globals.dart';

void main() {
  runApp(MaterialApp(
    home: ScanOperatorView(),
  ));
}

class ScanOperatorView extends StatefulWidget {
  const ScanOperatorView({Key? key}) : super(key: key);

  @override
  State<ScanOperatorView> createState() => _ScanOperatorViewState();
}

class _ScanOperatorViewState extends State<ScanOperatorView> {
  Future<void> _scanBarcode() async {
    String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    setGlobalBarcodeResult(barcodeResult);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OperatorPresensiView(barcodeResult: barcodeResult),
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
                            MaterialPageRoute(builder: (context) => HomeView()),
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
                            "Scan Mesin",
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
                    "Scan barcode pada mesin yang Anda gunakan!",
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
