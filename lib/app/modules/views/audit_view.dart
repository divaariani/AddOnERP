import 'package:flutter/material.dart';
import 'scanaudit_view.dart';
import 'home_view.dart';
import '../../routes/app_pages.dart';

void main() {
  runApp(MaterialApp(
    home: AuditView(),
  ));
}

class AuditView extends StatefulWidget {
  const AuditView({Key? key}) : super(key: key);
  @override
  State<AuditView> createState() => _AuditViewState();
}

class _AuditViewState extends State<AuditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
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
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Audit Stock",
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
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.search),
                        suffixIconConstraints: BoxConstraints(minWidth: 40),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CardTable(),
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
                                  builder: (context) => ScanAuditView()),
                            );
                          },
                          icon: Icon(Icons.qr_code_scanner),
                          label: Text('Scan QR Code'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(8, 77, 136, 136),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            minimumSize: Size(160, 48),
                          ),
                        ),
                        SizedBox(width: 10), // Adjust the spacing here
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.HOME);
                          },
                          icon: Icon(Icons.exit_to_app),
                          label: Text('Keluar'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(8, 77, 136, 136),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            minimumSize: Size(120, 48),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyData {
  final String kode;
  final String nama;
  final String kuantitas;

  MyData({
    required this.kode,
    required this.nama,
    required this.kuantitas,
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
        DataCell(Center(
            child: Text(
          entry.kode,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ))),
        DataCell(Center(
            child: Text(
          entry.nama,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ))),
        DataCell(Center(
            child: Text(
          entry.kuantitas,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ))),
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
      kode: 'K10',
      nama: 'Forklift',
      kuantitas: 'C1',
    ),
    MyData(
      kode: 'K10',
      nama: 'Forklift',
      kuantitas: 'C1',
    ),
    MyData(
      kode: 'K10',
      nama: 'Forklift',
      kuantitas: 'C1',
    ),
    MyData(
      kode: 'K10',
      nama: 'Forklift',
      kuantitas: 'C1',
    ),
    MyData(
      kode: 'K10',
      nama: 'Forklift',
      kuantitas: 'C1',
    ),
    MyData(
      kode: 'K10',
      nama: 'Forklift',
      kuantitas: 'C1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 26),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PaginatedDataTable(
              header: Text(
                'Audit Stock',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              columns: [
                DataColumn(
                    label: Text(
                  'Kode',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Nama Barang',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Kuantitas',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
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