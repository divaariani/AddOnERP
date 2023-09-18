import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'home_view.dart';
import 'monitoring_view.dart';
import 'monitoringriwayat_view.dart';

void main() {
  runApp(MaterialApp(
    home: MonitoringBarangView(),
  ));
}

class MonitoringBarangView extends StatefulWidget {
  const MonitoringBarangView({Key? key}) : super(key: key);
  @override
  State<MonitoringBarangView> createState() => _MonitoringBarangViewState();
}

class _MonitoringBarangViewState extends State<MonitoringBarangView> {
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
                            "Monitoring Stock",
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
                              text: "Aktifitas Produksi",
                              isActive: false,
                              targetPage: MonitoringView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Persediaan Barang",
                              isActive: true,
                              targetPage: MonitoringBarangView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Riwayat Perubahan",
                              isActive: false,
                              targetPage: MonitoringRiwayatView(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Barang',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "search",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.search)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rentang Waktu',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 200,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "search",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.search)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  CardTable(),
                  SizedBox(height: 10),
                ],
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
  final DateTime tanggal;
  final int produkx;
  final int produky;
  final int produkz;

  MyData({
    required this.tanggal,
    required this.produkx,
    required this.produky,
    required this.produkz,
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
  bool isCurrentPage = false;

  @override
  void initState() {
    super.initState();
    isCurrentPage = widget.targetPage.runtimeType == MonitoringBarangView;
  }

  void _navigateToTargetPage() {
    if (!isCurrentPage) {
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
        DataCell(Center(
            child: Text(
                dateFormat.format(entry.tanggal)))),
        DataCell(Center(child: Text(entry.produkx.toString()))),
        DataCell(Center(child: Text(entry.produky.toString()))),
        DataCell(Center(child: Text(entry.produkz.toString()))),
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
      tanggal: DateTime(2021, 8, 1),
      produkx: 10,
      produky: 20,
      produkz: 30,
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
              header: Align(
                alignment: Alignment.center,
                child: Text(
                  'Detail Data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              columns: [
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Stok Produk X')),
                DataColumn(label: Text('Stok Produk Y')),
                DataColumn(label: Text('Stok Produk Z')),
              ],
              source: MyDataTableSource(data),
              rowsPerPage: 4,
            ),
          ),
        ),
      ],
    );
  }
}
