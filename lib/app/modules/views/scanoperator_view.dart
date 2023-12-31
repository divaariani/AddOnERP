import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'home_view.dart';
import 'operatorpresensi_view.dart';
import '../utils/globals.dart';
import '../utils/app_colors.dart';

class ScanOperatorView extends StatefulWidget {
  const ScanOperatorView({Key? key}) : super(key: key);

  @override
  State<ScanOperatorView> createState() => _ScanOperatorViewState();
}

class _ScanOperatorViewState extends State<ScanOperatorView> {
  Future<void> _scanBarcode() async {
    String barcodeMachineResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    setGlobalBarcodeResult(barcodeMachineResult);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OperatorPresensiView(barcodeMachineResult: barcodeMachineResult),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
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
                  colors: [AppColors.blueTwo, AppColors.blueThree],
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
                        padding: const EdgeInsets.all(40),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.blueOne,
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
                                    primary: AppColors.blueOne,
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
                        "Scan barcode pada mesin yang Anda gunakan!",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.white,
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
                backgroundColor: AppColors.blueTwo,
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: const Text(
                  "Scan Mesin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
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
