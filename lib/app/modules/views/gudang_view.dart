import 'package:addon/app/modules/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'scangudang_view.dart';
import '../../routes/app_pages.dart';


void main() {
  runApp(MaterialApp(
    home: GudangView(),
  ));
}

class GudangView extends StatefulWidget {
  const GudangView({Key? key}) : super(key: key);
  @override
  State<GudangView> createState() => _GudangViewState();
}

class _GudangViewState extends State<GudangView> {
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
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(25),
                        //   ),
                        //   child: IconButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => HomeView()),
                        //       );
                        //     },
                        //     icon: Icon(Icons.arrow_back, color: Colors.black),
                        //   ),
                        // ),
                        // SizedBox(width: 16),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "In/Out Gudang",
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
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  SizedBox(height: 20), 
                  CardTable(),
                  SizedBox(height: 30), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanGudangView()),
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
                          minimumSize: Size(160, 48),
                        ),
                      ),
                    ],
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
    color: Colors.white,
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color.fromARGB(49, 14, 65, 142)!,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Gudang',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
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
                            'Kode Barang',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Nama Barang',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Lokasi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Tanggal',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(
                      children: [
                        TableCell(
                          child:
                              Center(child: Text('K10', style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Forklift', style: tableCellStyle)),
                        ),
                        TableCell(
                          child:
                              Center(child: Text('C1', style: tableCellStyle)),
                        ),
                        TableCell(
                          child: Center(
                            child:
                                Text('8 Januari 2024', style: tableCellStyle),
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
        SizedBox(height: 20), // Add spacing between cards
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color.fromARGB(150, 255, 255, 255)!,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data IN Gudang',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 3, 1, 49),
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
                            'Kode Barang',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Nama Barang',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Lokasi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Tanggal',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(
                      children: [
                        TableCell(
                          child:
                              Center(child: Text('K10', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Forklift', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(child: Text('C1', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('8 Januari 2024', style: tableCellnew),
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
        SizedBox(height: 20),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color.fromARGB(150, 255, 255, 255)!,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data OUT Gudang',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 3, 1, 49),
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
                            'Kode Barang',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Nama Barang',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Lokasi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Tanggal',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 3, 1, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    TableRow(
                      children: [
                        TableCell(
                          child:
                              Center(child: Text('K10', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(
                              child: Text('Forklift', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(child: Text('C1', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('8 Januari 2024', style: tableCellnew),
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