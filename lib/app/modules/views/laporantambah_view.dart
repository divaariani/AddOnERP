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
  final idController = TextEditingController();
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userIdLogin = "";
  final plotnumberController = TextEditingController();
  final stateController = TextEditingController();

  double fontSize = 16.0;
  DateTime? _selectedDay;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _createTglController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_fetchUserId();

    String plotnumberList = widget.resultBarangQc.join('\n');
    plotnumberController.text = plotnumberList;
  }

  void _updateCreateTgl() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    _createTglController.text = formattedDate;
  }

  Future<void> _fetchUserId() async {
    userIdLogin = await _sessionManager.getUserId() ?? "";
    setState(() {});
  }

  Future<void> _submitStock() async {
    //final int userid = int.parse(idController.text);
    //final String pbarcode_mobil = pbarcode_mobilController.text;

    String successMessage = 'Congratulations';
    List<String> errorMessages = [];

    try {
      //await _fetchCurrentTime();
      final int userId = int.parse(userIdLogin);
      final int id = int.tryParse(['id'].toString()) ?? 0;
      for (String plotnumber in widget.resultBarangQc) {
        ResponseModel response = await LaporanTambahController.postFormData(
          id: id,
          puserid: userId,
          //pbarcode_mobil: pbarcode_mobil,
          plotnumber: plotnumber,

          ///state: state,
        );

        if (response.status == 0) {
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
      } else {
        Get.snackbar('Stock Berhasil Diupload', successMessage);
      }

      widget.resultBarangQc.clear();
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
    // double screenWidth = MediaQuery.of(context).size.width;

    // if (screenWidth > 600) {
    //   fontSize = 24.0;
    // }

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
              decoration: BoxDecoration(
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
                    SizedBox(height: 70),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tgl Kp',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              readOnly: true,
                              controller: _dateController,
                              decoration: InputDecoration(
                                hintText: "Pilih tgl",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate:
                                                _selectedDay ?? DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101));
                                    if (selectedDate != null &&
                                        selectedDate != _selectedDay) {
                                      setState(() {
                                        _selectedDay = selectedDate;
                                        _dateController.text =
                                            DateFormat('yyy-MM-dd')
                                                .format(selectedDate);
                                        _fetchUserId();
                                        _updateCreateTgl();
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User ID',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
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
                    SizedBox(height: 25),
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
                          Spacer(),
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
                                suffixIcon: Icon(Icons.timer),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.scanner,
                                color: const Color.fromARGB(255, 7, 93, 163),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScanQcBarangView()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: const Color.fromARGB(255, 7, 93, 163),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
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
                            SizedBox(height: 20),
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
                                SizedBox(width: 40),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Lot Number',
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.white,
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
                            margin: EdgeInsets.symmetric(vertical: 10), 
                          ),
                        ),
                      ],
                    ),
                    (SizedBox(height: 10)),
                    ListView.builder(
                      itemCount: globalBarcodeBarangQcResults.isEmpty
                          ? 1
                          : globalBarcodeBarangQcResults.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (globalBarcodeBarangQcResults.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: 120,
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "Id Kp",
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
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: 200,
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "Lot Barang",
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
                              ],
                            ),
                          );
                        } else {
                          int id = index + 1;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: 120,
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "$id",
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
                                SizedBox(width: 30),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText:
                                            globalBarcodeBarangQcResults[index],
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
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _submitStock();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LaporanHasilView()),
                              );
                            },
                            icon: Icon(Icons.cloud_upload, size: 15),
                            label:
                                Text('UPLOAD', style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(8, 77, 136, 136),
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4,
                              minimumSize: Size(100, 48),
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
                backgroundColor: Color(0xFF2A77AC),
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LaporanHasilView(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: Text(
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
