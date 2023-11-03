import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/customer_controller.dart';

class ScanCustomerView extends StatefulWidget {
  const ScanCustomerView({Key? key}) : super(key: key);

  @override
  State<ScanCustomerView> createState() => _ScanCustomerViewState();
}

class _ScanCustomerViewState extends State<ScanCustomerView> {
  final customerContoller = Get.find<CustomerController>();

  bool _isScanning = false;

  MobileScannerController mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    detectionTimeoutMs: 500,
    returnImage: true,
  );

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
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      height: 600,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF084D88),
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _isScanning
                            ? const SizedBox()
                            : MobileScanner(
                                startDelay: true,
                                errorBuilder: (p0, p1, p2) {
                                  return const Center(
                                    child: Text(
                                      "Error",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                                controller: mobileScannerController,
                                onDetect: (capture) async {
                                  final List<Barcode> barcodes =
                                      capture.barcodes;
                                  final Uint8List? image = capture.image;
                                  for (final barcode in barcodes) {
                                    debugPrint(
                                        'Barcode found! ${barcode.rawValue}');
                                  }
                                  if (image != null ||
                                      barcodes[0].rawValue != null) {
                                    customerContoller.valueFromBarcode.value =
                                        '${barcodes[0].rawValue}';
                                    Navigator.pop(context);
                                    _isScanning = true;
                                    setState(() {});
                                  }
                                },
                              ),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Scan barcode nomor order!",
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
                  Navigator.pop(context); 
                },
                child: Image.asset(
                  'assets/icon.back.png',
                  width: 40,
                  height: 40,
                ),
              ),
              title: const Text(
                "Scan Nomor Order",
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
    );
  }
}
