import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'scanauditbarang_view.dart';
import 'home_view.dart';

class AuditLokasiView extends StatefulWidget {
  final String result;
  final String resultBarang;
  
  AuditLokasiView({required this.result, required this.resultBarang, Key? key}) : super(key: key);

  @override
  State<AuditLokasiView> createState() => _AuditLokasiViewState();
}

class _AuditLokasiViewState extends State<AuditLokasiView> {
  List<String> cardTableData = [];

  @override
  Widget build(BuildContext context) {
    final cardTable = CardTable(data: cardTableData);

    if (widget.resultBarang.isNotEmpty) {
      cardTableData.add(widget.resultBarang);
    }

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
                                'LOKASI: ',
                                style: GoogleFonts.poppins(
                                  color: Colors.blue[900],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.result,
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
                  SizedBox(height: 10),
                  cardTable,
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
                                  builder: (context) => ScanAuditBarangView()),
                            );
                          },
                          icon: Icon(Icons.qr_code_scanner, size: 15),
                          label: Text('Scan Barang',
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
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            // onpressed save data logic
                          },
                          icon: Icon(Icons.save_alt, size: 15),
                          label: Text('Simpan', style: TextStyle(fontSize: 12)),
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
                  SizedBox(height: 20),
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
  final String lotbarang;

  MyData({
    required this.lotbarang,
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
          entry.lotbarang,
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

class CardTable extends StatefulWidget {
  final List<String> data; // Accept a list of strings as data

  CardTable({required this.data});

  @override
  _CardTableState createState() => _CardTableState();
}

class _CardTableState extends State<CardTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.data.isEmpty
                ? EmptyData()
                : DataTable(
                    columns: [
                      DataColumn(
                        label: SizedBox(
                          width: 0.6 * MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              'Lot Barang',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: widget.data.map((item) {
                      return DataRow(cells: [
                        DataCell(
                          // Display each item from the data list
                          Text(
                            item,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                    // Change rowsPerPage to adjust the number of rows per page
                    //rowsPerPage: 5,
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