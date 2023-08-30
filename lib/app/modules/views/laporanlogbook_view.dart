import 'home_view.dart';
import 'laporan_view.dart';
import 'laporanqc_view.dart';
import 'laporanrelease_view.dart';
import 'laporanstok_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: LaporanLogbookView(),
  ));
}

class LaporanLogbookView extends StatefulWidget {
  const LaporanLogbookView({Key? key}) : super(key: key);
  @override
  State<LaporanLogbookView> createState() =>
      _LaporanLogbookViewState();
}

class MyData {
  final int no;
  final DateTime tanggalProduksi;
  final String kodeProduksi;
  final String produk;
  final int jumlah;

  MyData({
    required this.no,
    required this.tanggalProduksi,
    required this.kodeProduksi,
    required this.produk,
    required this.jumlah,
  });
}

class CustomButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final Widget targetPage;

  CustomButton(
      {required this.text, required this.isActive, required this.targetPage});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  void _navigateToTargetPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            widget.targetPage,
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToTargetPage,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isActive
                ? [
                    const Color.fromRGBO(255, 255, 255, 1),
                    Color.fromARGB(56, 0, 151, 251)
                  ]
                : [
                    Color.fromARGB(255, 255, 255, 255),
                    const Color.fromRGBO(96, 187, 231, 1)
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: widget.isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]
              : [],
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.isActive
                ? Colors.white
                : const Color.fromRGBO(8, 77, 136, 1),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _LaporanLogbookViewState extends State<LaporanLogbookView> {
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
                colors: [Color(0xFF5AB4E1), Color(0xFF2A77AC)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView()),
                              );
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "Laporan",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Produksi",
                              isActive: false,
                              targetPage: LaporanView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Quality Control",
                              isActive: false,
                              targetPage: LaporanQcView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Stock",
                              isActive: false,
                              targetPage: LaporanStokView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Release",
                              isActive: false,
                              targetPage: LaporanReleaseView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Log Book",
                              isActive: true,
                              targetPage: LaporanLogbookView(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "LAPORAN QUALITY LOGBOOK",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Periode",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  CardTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<MyData> data;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

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
        DataCell(Center(child: Text((index + 1).toString()))),
        DataCell(Center(
            child: Text(
                dateFormat.format(entry.tanggalProduksi)))), 
        DataCell(Center(child: Text(entry.kodeProduksi))),
        DataCell(Center(child: Text(entry.produk))),
        DataCell(Center(child: Text(entry.jumlah.toString()))),
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

class CardTable extends StatelessWidget {
  final List<MyData> data = [
    MyData(
      no: 1,
      tanggalProduksi: DateTime(2021, 8, 1),
      kodeProduksi: 'C1',
      produk: 'Kabel C',
      jumlah: 100,
    ),
    MyData(
      no: 1,
      tanggalProduksi: DateTime(2021, 9, 2),
      kodeProduksi: 'A1',
      produk: 'Kabel A',
      jumlah: 100,
    ),
    MyData(
      no: 1,
      tanggalProduksi: DateTime(2021, 10, 4),
      kodeProduksi: 'B1',
      produk: 'Kabel B',
      jumlah: 100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color.fromARGB(255, 255, 255, 255)!,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PaginatedDataTable(
              columns: [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Tanggal Produksi')),
                DataColumn(label: Text('kode Produksi')),
                DataColumn(label: Text('Produk')),
                DataColumn(label: Text('Jumlah')),
              ],
              source: MyDataTableSource(data),
              rowsPerPage: 5,
            ),
          ),
        ),
      ],
    );
  }
}