import 'package:addon/app/modules/views/home_view.dart';
import 'package:addon/app/modules/views/monitoring_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'monitoringriwayat_view.dart';

void main() {
  runApp(MaterialApp(
    home: BarangView(),
  ));
}

class BarangView extends StatefulWidget {
  const BarangView({Key? key}) : super(key: key);

  @override
  State<BarangView> createState() => _BarangViewState();
}

class CustomButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPressed;  
  CustomButton(
      {required this.text, required this.isActive, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isActive
              ? Colors.blue.shade900
              : Colors.blue.shade300, 
          borderRadius: BorderRadius.circular(30),
          boxShadow: widget.isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), 
                    blurRadius: 4,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class _BarangViewState extends State<BarangView> {
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
                colors: [ Color(0xFF5AB4E1), Color(0xFF2A77AC)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 32, left: 16, right: 16, bottom: 32),
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
                                "Monitoring Stock⠀⠀⠀⠀",
                                style: TextStyle(
                                  fontSize: 24,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text: "Produksi",
                        isActive:
                          false, 
                        onPressed: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MonitoringView()),
                              );
                        },
                      ),
                      CustomButton(
                        text: "Barang",
                        isActive:
                            true, 
                        onPressed: () {
                        },
                      ),
                      CustomButton(
                        text: "Riwayat",
                        isActive: false, 
                        onPressed: () {
                         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MonitoringRiwayatView()),
                              );
                        },
                      ),
                    ],
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
                              'Rentang waktu',
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
                  SizedBox(height: 3),
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

class CardTable extends StatelessWidget {
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
        SizedBox(height: 20),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color.fromARGB(255, 255, 255, 255)!,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Data',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue.shade800,
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
                            'Tanggal',
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
                            'Stok Prudk X',
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
                            'Stok Prudk X',
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
                            'Stok Prudk Y',
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