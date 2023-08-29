import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'laporan_view.dart';
import 'scanproduk_view.dart';

void main() {
  runApp(MaterialApp(
    home: ProduksiView(),
  ));
}

class ProduksiView extends StatefulWidget {
  const ProduksiView({Key? key}) : super(key: key);
  @override
  State<ProduksiView> createState() => _ProduksiViewState();
}

class _ProduksiViewState extends State<ProduksiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    builder: (context) => LaporanView()),
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
                            "Produk",
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
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScanProdukView()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tambah Produksi",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Icon(
                                      Icons.add_box,
                                      color: Colors.blue[900],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 200,
                            height: 60,
                            padding: const EdgeInsets.only(right: 7),
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
                                suffixIconConstraints:
                                    BoxConstraints(minWidth: 40),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CardTable(),
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

class CardTable extends StatelessWidget {
  final TextStyle tableCellStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    color: Colors.blue[900],
    fontSize: 11,
  );
  final TextStyle tableCellnew = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 3, 1, 49),
    fontSize: 11,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 7),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Produksi',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[900],
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0, 4),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.black),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Tanggal',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.blue[900],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Kode',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.blue[900],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Nama Produk',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.blue[900],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Status QC',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.blue[900],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Jumlah Produksi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.blue[900],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Aksi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.blue[900],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('7 Januari 2024',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('NA2XSY',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Aluminium Conductor',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Al/XLPE/CTS/PVC',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('80',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Jalan',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('7 Januari 2024',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('NA2XSY',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Aluminium Conductor',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Al/XLPE/CTS/PVC',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('80',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Jalan',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('7 Januari 2024',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('NA2XSY',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Aluminium Conductor',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Al/XLPE/CTS/PVC',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('80',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Jalan',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('7 Januari 2024',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('NA2XSY',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Aluminium Conductor',
                                  textAlign: TextAlign.center,
                                  style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Al/XLPE/CTS/PVC',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('80',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Jalan',
                                textAlign: TextAlign.center,
                                style: tableCellStyle),
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
      ],
    );
  }
}
