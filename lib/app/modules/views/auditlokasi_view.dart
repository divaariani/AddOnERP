import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'scanauditbarang_view.dart';
import 'home_view.dart';
import 'refresh_view.dart';
import '../utils/globals.dart';
import '../utils/sessionmanager.dart';
import '../utils/app_colors.dart';
import '../controllers/audit_controller.dart';
import '../controllers/response_model.dart';
import '../controllers/notification_controller.dart';

class AuditLokasiView extends StatefulWidget {
  String result;
  List<String> resultBarang;

  AuditLokasiView({required this.result, required this.resultBarang, Key? key}) : super(key: key);

  @override
  State<AuditLokasiView> createState() => _AuditLokasiViewState();
}

class _AuditLokasiViewState extends State<AuditLokasiView> {
  late DateTime currentTime;
  final AuditController _auditUserController = Get.put(AuditController());
  final SessionManager sessionManager = SessionManager();
  final idController = TextEditingController();
  final pbarangController = TextEditingController();
  final plokasiController = TextEditingController();
  String barcodeAuditLokasiResult = globalBarcodeLokasiResult;
  String idInventory = '';
  String userIdLogin = "";

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _fetchCurrentTime();
    _auditUserController.fetchIdInventory().then((id) {
      setState(() {
        idInventory = id.toString();
        idController.text = idInventory.toString();
      });
    });
    String pbarangList = widget.resultBarang.join('\n');
    plokasiController.text = barcodeAuditLokasiResult;
    pbarangController.text = pbarangList;
  }

  Future<void> _fetchUserId() async {
    userIdLogin = await sessionManager.getUserId() ?? "";
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
    final String title = 'Stock';
    final String description = 'Anda berhasil upload stok barang';
    final String date = DateFormat('yyyy-MM-dd HH:mm').format(currentTime);

    try {
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
          SnackBar(
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
    final int id = int.parse(idController.text);
    final String plokasi = plokasiController.text;
    List<String> errorMessages = [];
    bool success = true; 

    try {
      await _fetchCurrentTime();

      for (String pbarang in widget.resultBarang) {
        ResponseModel response = await AuditController.postFormStock(
          id: id,
          pbarang: pbarang,
          plokasi: plokasi,
          pdate: currentTime,
        );

        if (response.status == 1) {
          success = true;
        } else if (response.status == 0) {
          errorMessages.add('Request gagal: ${response.message}');
        } else if (response.status != 1) {
          errorMessages.add('Terjadi kesalahan: Response tidak valid.');
        }
      }

      if (success) {
        _submitNotif();
      }

      if (errorMessages.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessages.join('\n')),
          ),
        );
      } else {
        Get.snackbar('Stock Berhasil Diupload', 'Congratulations');
      }

      widget.resultBarang.clear();
      setState(() {
        widget.resultBarang = [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
    }
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 26),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Text(
                                  'LOKASI: ',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.blueOne,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  barcodeAuditLokasiResult,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.blueOne,
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
                      visible: widget.resultBarang.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Container(
                          width: 1 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColors.white,
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
                                    color: AppColors.blueOne,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.resultBarang.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final item = widget.resultBarang[index];
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                    content: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 10),
                                                            child: Image.asset(
                                                              'assets/icon.warning.png',
                                                              width: 70,
                                                              height: 70,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Text(
                                                            'Apakah yakin akan dihapus?',
                                                            textAlign: TextAlign.center,
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              color: AppColors.blueOne,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: AppColors.greyThree,
                                                                  elevation: 0,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                ),
                                                                child: const Text(
                                                                  'Batal',
                                                                  style: TextStyle(
                                                                    color: AppColors.blueOne,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(width: 10),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    widget.resultBarang.removeAt(index);
                                                                  });
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: Colors.red,
                                                                  elevation: 0,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                ),
                                                                child: const Text(
                                                                  'Hapus',
                                                                  style: TextStyle(
                                                                    color: AppColors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Image.asset(
                                              'assets/icon.delete.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          item,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            color: AppColors.blueOne,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.resultBarang.isEmpty,
                      child: const EmptyData(),
                    ),
                    const SizedBox(height: 20),
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
                                    builder: (context) =>
                                        const ScanAuditBarangView()),
                              );
                            },
                            icon: Image.asset(
                              'assets/icon.scan.png',
                              width: 15,
                              height: 15,
                            ),
                            label: const Text('Scan Barang', style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.blueOne,
                              onPrimary: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                              minimumSize: const Size(130, 48),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: () {
                              _submitStock();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => RefreshAuditTable()),
                              );
                            },
                            icon: Image.asset(
                              'assets/icon.upload.png', 
                              width: 15, 
                              height: 15, 
                            ),
                            label: const Text('Upload', style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.blueOne,
                              onPrimary: AppColors.white,
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
                  "Audit Stock",
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

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: 1 * MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.nodata.png',
              width: 30,
              height: 30,
              color: AppColors.blueOne,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Tidak ada hasil scan barang',
                style: GoogleFonts.poppins(
                  color: AppColors.blueOne,
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
