import 'package:addon/app/modules/views/laporantambah_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_view.dart';
import '../controllers/laporanview_controller.dart';
import '../utils/globals.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';


void main() {
  runApp( const MaterialApp(
    home: LaporanHasilView(),
  ));
}

class LaporanHasilView extends StatefulWidget {
  const LaporanHasilView({Key? key}) : super(key: key);
  @override
  State<LaporanHasilView> createState() => _LaporanHasilViewState();
}

class _LaporanHasilViewState extends State<LaporanHasilView> {
  late DateTime currentTime;
  int page = 1;
  int pageSize = 10;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    _fetchCurrentTime();
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
                    Align(
                      alignment: const Alignment(0.85, -1.0),
                      child: Container(
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
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 7, 93, 163),
                          ),
                          onPressed: () {
                            Get.to(() => LaporanTambahView(
                                result: '',
                                resultBarangQc: globalBarcodeBarangResults));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CardTable(searchText),
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
                      MaterialPageRoute(builder: (context) =>const HomeView()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: const Text(
                  "Laporan Hasil Produksi",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                  "Laporan Hasil Produksi",
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

class MyData {
  final int? nomor_kp;
  final DateTime? tgl_kp;
  final int? userid;
  final String? dibuatoleh;
  final DateTime? dibuattgl;

  MyData({
    required this.nomor_kp,
    required this.tgl_kp,
    required this.userid,
    required this.dibuatoleh,
    required this.dibuattgl,
  });
}

class MyDataTableSource extends DataTableSource {
  final List<MyData> data;
  MyDataTableSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final entry = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.nomor_kp?.toString() ?? "",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              (entry.tgl_kp != null)
                  ? DateFormat('yyyy-MM-dd').format(entry.tgl_kp!)
                  : "",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.dibuatoleh ?? "",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.dibuattgl != null
                  ? DateFormat('yyyy-MM-dd HH:mm:ss').format(entry.dibuattgl!)
                  : "",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class CardTable extends StatefulWidget {
  final String searchText;
  CardTable(this.searchText);

  @override
  _CardTableState createState() => _CardTableState(searchText);
}

class _CardTableState extends State<CardTable> {
  List<MyData> _data = [];
  bool _isLoading = false;
  final String searchText;
  _CardTableState(this.searchText);

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await LaporanViewController.postFormData(
        nomor_kp: 1,
        tgl_kp: DateTime.now(),
        userid: 1,
        dibuatoleh: '',
        dibuattgl: DateTime.now(),
      );

      final List<dynamic> nameDataList = response.data;
      //print('API Response: $nameDataList');

      final List<MyData> myDataList = nameDataList.map((data) {
        int nomor_kp = int.tryParse(data['nomor_kp'].toString()) ?? 0;
        DateTime tgl_kp = DateTime.parse(data['tgl_kp']);
        int userid = int.tryParse(data['userid'].toString()) ?? 0;
        String dibuatoleh = data['dibuatoleh'];
        DateTime dibuattgl = DateTime.parse(data['dibuattgl']);

        return MyData(
          nomor_kp: nomor_kp,
          tgl_kp: tgl_kp,
          userid: userid,
          dibuatoleh: dibuatoleh,
          dibuattgl: dibuattgl,
        );
        //print('$MyData');
      }).toList();

      setState(() {
        _data = myDataList.where((data) {
          return data.nomor_kp
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase());
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const  SizedBox(height: 10),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 26),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : _data.isEmpty
                        ? EmptyData()
                        : PaginatedDataTable(
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Nomor Kp',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Tanggal Kp',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Pembuat',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Tanggal',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                            source: MyDataTableSource(_data),
                            rowsPerPage: 10,
                          ),
              ],
            ),
          ),
        ),
      ],
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
