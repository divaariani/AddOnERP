import 'package:intl/intl.dart';
import '../utils/sessionmanager.dart';
import 'home_view.dart';
import 'laporanhasil_view.dart';
import 'package:flutter/material.dart';
import 'scanqcbarang_view.dart';
import 'package:get/get.dart';
import '../utils/globals.dart';
import '../controllers/laporantambah_controller.dart';
import '../controllers/response_model.dart';
import 'refresh_view.dart';
import 'dart:async';
import '../controllers/notification_controller.dart';
import '../controllers/notificationview_controller.dart';


class LaporanTambahView extends StatefulWidget {
  String result;
  List<String> resultBarangQc;

  LaporanTambahView(
      {required this.result, required this.resultBarangQc, Key? key})
      : super(key: key);

  @override
  State<LaporanTambahView> createState() => _LaporanTambahViewState();
}

class _LaporanTambahViewState extends State<LaporanTambahView> {
  String barcodeBarangqcResult = globalBarcodeBarangqcResult;
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userIdLogin = "";
  final plotnumberController = TextEditingController();
  final stateController = TextEditingController();
  double fontSize = 16.0;
  DateTime? _selectedDay;
  final idController = TextEditingController();
  final _dateController = TextEditingController();
  final _createTglController = TextEditingController();
  Timer? _timer;
  String? globalTglKP;
  late DateTime currentTime;
  
  
 @override
  void initState() {
    super.initState();
    String plotnumberList = widget.resultBarangQc.join('\n');
    plotnumberController.text = plotnumberList;
    _fetchUserId();
    _fetchCurrentTime();
    _createTglController.text = _getFormattedCurrentDateTime();
    
     if (globalTglKP != null && globalTglKP!.isNotEmpty) {
    _selectedDay = DateFormat('yyyy-MM-dd').parse(globalTglKP!);
    }
    else {
      _selectedDay = DateTime.now();
    }

    _dateController.text = globalTglKP ?? _getFormattedCurrentDateTime();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _updateCreateTgl();
      });

    _fetchUserId();
  }

  String _getFormattedCurrentDateTime() {
      DateTime now = DateTime.now();
      return DateFormat('yyyy-MM-dd').format(now);
    }

  void _updateSelectedDay() {
  if (_selectedDay != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay!);
    globalTglKP = formattedDate;

    _dateController.text = formattedDate;
  }
}

  void _updateCreateTgl() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
    setState(() {
      _createTglController.text = formattedDate;
    });
  }

  Future<void> _fetchUserId() async {
    userIdLogin = await _sessionManager.getUserId() ?? "";
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
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
    const String title = 'Laporan Produksi';
    const String description = 'Anda berhasil upload barang';

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
    String successMessage = 'Selamat';
    List<String> errorMessages = [];

    try {
      final int userId = int.parse(userIdLogin);
      final String uid = userIdLogin;
      String tglKpText = _dateController.text;
      String createdateText = _createTglController.text;


      DateTime tglkp = DateFormat('yyyy-MM-dd').parse(tglKpText);
      DateTime createdate = DateFormat('yyyy-MM-dd HH:mm').parse(createdateText);

      final List<Map<String, String?>> inventoryDetails = widget.resultBarangQc
          .map((lotnumber) => {
                'lotnumber': lotnumber,
                'state': 'draft',
              })
          .toList();

      ResponseModel response = await LaporanTambahController.postFormData(
        p_tgl_kp: tglkp,
        p_userid: userId,
        p_uid: uid,
        p_createdate: createdate,
        p_inventory_details: inventoryDetails,
      );

      if (response.status == 0) {
        errorMessages.add('Permintaan gagal: ${response.message}');
      } else if (response.status != 1) {
        errorMessages.add('Terjadi kesalahan: Respon tidak valid.');
      }

      if (errorMessages.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessages.join('\n')),
          ),
        );
      } else {
        Get.snackbar('Stok Berhasil Diunggah', successMessage);
      }

      _submitNotif();

      widget.resultBarangQc.clear();
      _dateController.clear(); 
      _createTglController.clear();

      setState(() {
        widget.resultBarangQc = [];
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
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tgl Kp',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDay ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (selectedDate != null &&
                                    selectedDate != _selectedDay) {
                                  setState(() {
                                    _selectedDay = selectedDate;
                                    _dateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                    _fetchUserId();
                                    _updateCreateTgl();
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  readOnly: true,
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    //hintText: "Pilih tgl",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 19),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'User ID',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    ' *',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: fontSize,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller:
                                  TextEditingController(text: userIdLogin),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 19),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Createdate',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              controller: _createTglController,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 19),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                if(_selectedDay != null){ 
                                  DateTime selectedDay = _selectedDay ?? DateTime.now();
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScanQcBarangView(date: formattedDate),
                                    ),
                                  );
                                }
                              },
                              child: Image.asset(
                                'assets/barcode.png',
                                width: 30,
                                height: 30,
                                color: const Color.fromARGB(255, 7, 93, 163),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Detail Laporan Hasil Produksi',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: fontSize,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ID KP',
                                        style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Lot Number',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.89,
                            height: 3,
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      itemCount: globalBarcodeBarangQcResults.isEmpty
                          ? 1
                          : globalBarcodeBarangQcResults.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: TextField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: globalBarcodeBarangQcResults
                                                  .isEmpty
                                              ? "Id Kp"
                                              : (index + 1).toString(),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: TextField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: globalBarcodeBarangQcResults
                                                  .isEmpty
                                              ? "Lot Number"
                                              : globalBarcodeBarangQcResults[
                                                  index],
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 13),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submitStock();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => RefreshLaporanTable()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(8, 77, 136, 136),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                              minimumSize: Size(100, 48),
                            ),
                            child: Row(
                              children: [
                                const Text('Submit', style: TextStyle(fontSize: 14)),
                                const SizedBox(
                                    width:
                                        8), 
                                Image.asset(
                                  'assets/send.png', 
                                  width:
                                      15, 
                                  height:
                                      15, 
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor:const Color(0xFF2A77AC),
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LaporanHasilView(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: const Text(
                  "Tambah Laporan",
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
