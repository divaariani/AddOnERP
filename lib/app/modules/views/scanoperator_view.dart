import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import 'operatorstatus_view.dart';
import '../utils/globals.dart';
import '../utils/sessionmanager.dart';
import '../controllers/absensi_controller.dart';
import '../controllers/response_model.dart';

void main() {
  runApp(const MaterialApp(
    home: ScanOperatorView(),
  ));
}

class ScanOperatorView extends StatefulWidget {
  const ScanOperatorView({Key? key}) : super(key: key);

  @override
  State<ScanOperatorView> createState() => _ScanOperatorViewState();
}

class _ScanOperatorViewState extends State<ScanOperatorView> {
  late DateTime currentTime;
  final idwcController = TextEditingController();
  final tapController = TextEditingController();

  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userIdLogin = "";
  String userName = "";
  String barcodeMachineResult = globalBarcodeMesinResult;

  Future<void> _fetchUserId() async {
    userIdLogin = await _sessionManager.getUserId() ?? "";
    userName = await _sessionManager.getUsername() ?? "";
    setState(() {});
  }

  Future<void> fetchCurrentTime() async {
    try {
      setState(() {
        currentTime = DateTime.now();
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    currentTime = DateTime.now();
    idwcController.text = barcodeMachineResult;
  }

  Future<void> _submitForm() async {
    final int idwc = int.tryParse(idwcController.text) ?? 0;
    final int userId = int.tryParse(userIdLogin) ?? 0;
    final String tap = tapController.text;

    try {
      await fetchCurrentTime();

      ResponseModel response = await AbsensiController.postFormData(
        idwc: idwc,
        userId: userId,
        oprTap: currentTime.toString(),
        tap: tap,
      );

      if (response.status == 1) {
        if (tap == "I") {
          Get.snackbar('IN Mesin', 'Operator $userName');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return OperatorStatusView();
              },
            ),
          );
        }
      } else if (response.status == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request gagal: ${response.message}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan: Response tidak valid.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    }
  }

  Future<void> _scanBarcode() async {
    String barcodeMachineResult = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    idwcController.text = barcodeMachineResult;
    tapController.text = "I";

    await _submitForm();

    setGlobalBarcodeResult(barcodeMachineResult);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OperatorStatusView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
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
                              color: Color(0xFF084D88),
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
                                        color: Color(0xFFFAFAFA),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Scan QR Code",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFFAFAFA),
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
                    const Center(
                      child: Text(
                        "Scan barcode pada mesin yang Anda gunakan!",
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
                      MaterialPageRoute(builder: (context) => HomeView()),
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
                    color: Color(0xFFFAFAFA),
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
