import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import 'gudangout_view.dart';
import 'scangudangbarang_view.dart';
import '../utils/globals.dart';
import '../controllers/gudangmobil_controller.dart';
import '../controllers/response_model.dart';
import '../utils/sessionmanager.dart';
import '../controllers/notification_controller.dart';
import 'package:intl/intl.dart';
import 'refresh_view.dart';


class GudangMobilView extends StatefulWidget {
  String result;
  List<String> resultBarangGudang;

  GudangMobilView({required this.result, required this.resultBarangGudang, Key? key})
      : super(key: key);

  @override
  State<GudangMobilView> createState() => _GudangMobilViewState();
}

class _GudangMobilViewState extends State<GudangMobilView> {
  String barcodeGudangMobilResult = globalBarcodeMobilResult;
  String userIdLogin = "";
  late DateTime currentTime;
  final plotnumberController = TextEditingController();
  final pbarcode_mobilController = TextEditingController();
  final stateController = TextEditingController();
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _fetchCurrentTime();
    String plotnumberList= widget.resultBarangGudang.join('\n');
    pbarcode_mobilController.text = barcodeGudangMobilResult;
    plotnumberController.text = plotnumberList;
  }

  Future<void> _fetchUserId() async {
    userIdLogin= await _sessionManager.getUserId() ?? "";
    setState(() {});
  }

  Future<void> _fetchCurrentTime() async {
    try {
      setState(() {
        currentTime = DateTime.now();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _submitNotif() async {
    final int id = int.parse(userIdLogin);
    const String title = 'Stock';
    const String description = 'Anda berhasil upload stok barang';

    try {
      final String date = DateFormat('yyyy-MM-dd HH:mm').format(currentTime);
      await _fetchCurrentTime();

      ResponseModel response = await NotificationController.postNotification(
        userid: id,
        title: title,
        description: description,
        date: date,
      );

      if (response.status == 1) {
        print('notification insert success');
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

  Future<void> _submitStock() async {
    final String pbarcode_mobil = pbarcode_mobilController.text;
    String successMessage = 'Congratulations';
    List<String> errorMessages = [];
    
    try {
      await _fetchCurrentTime();
      final int userId = int.parse(userIdLogin);
      for (String plotnumber in widget.resultBarangGudang) {
        ResponseModel response = await GudangMobilController.postFormData(
          puserid: userId,
          pbarcode_mobil: pbarcode_mobil,
          plotnumber: plotnumber,
        );

        if (response.status == 1) {
          Get.snackbar('Stock Berhasil Diupload', 'Congratulations');
          _submitNotif();
        } else if (response.status == 0) {
          errorMessages.add('Request gagal: ${response.message}');
        } else if (response.status != 1) {
          errorMessages.add('Terjadi kesalahan: Response tidak valid.');
        }
      }

      if (errorMessages.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessages.join('\n')),
          ),
        );
      }

      widget.resultBarangGudang.clear();
      setState(() {
        widget.resultBarangGudang = [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    }
  }

  void refreshNavigateToLaporantHasilView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const GudangOutView(),
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
            decoration: const BoxDecoration(
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeView()),
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
                            "Warehouse",
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Text(
                                'Kode Mobil: ',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                barcodeGudangMobilResult,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: widget.resultBarangGudang.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Container(
                        width: 1 * MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                'Daftar Barang',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.resultBarangGudang.join('\n'),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.resultBarangGudang.isEmpty,
                    child: EmptyData(),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScanGudangBarangView()),
                            );
                          },
                          icon: const Icon(Icons.qr_code_scanner, size: 15),
                          label: const Text('Scan Barang',
                              style: TextStyle(fontSize: 12)),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(8, 77, 136, 136),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            minimumSize: Size(130, 48),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            _submitStock();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => RefreshGudangTable()),
                            );
                          },
                          icon: const Icon(Icons.cloud_upload, size: 15),
                          label: const Text('UPLOAD', style: TextStyle(fontSize: 12)),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(8, 77, 136, 136),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            minimumSize: const Size(100, 48),
                          ),
                        ),
                      ],
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

class EmptyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: 1 * MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.nodata.png',
              width: 30,
              height: 30,
              color: Colors.blue[900],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Tidak ada hasil scan barang',
                style: GoogleFonts.poppins(
                  color: Colors.blue[900],
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
