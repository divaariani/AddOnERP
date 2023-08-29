import 'package:addon/app/modules/views/home_view.dart';
import 'package:addon/app/modules/views/monitoringbarang_view.dart';
import 'package:addon/app/modules/views/monitoringriwayat_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: MonitoringView(),
  ));
}

class MonitoringView extends StatefulWidget {
  const MonitoringView({Key? key}) : super(key: key);
  @override
  State<MonitoringView> createState() => _MonitoringViewState();
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

class _MonitoringViewState extends State<MonitoringView> {
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
                                textAlign: TextAlign.left,
                                "Monitoring Stock",
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
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              16), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    3), 
                            child: CustomButton(
                              text: "Aktivitas Produksi",
                              isActive: true,
                              targetPage: MonitoringView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    3), 
                            child: CustomButton(
                              text: "Persediaan Barang",
                              isActive: false,
                              targetPage: MonitoringBarangView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    3), 
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
                          children: [],
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
                                prefixIcon: Icon(Icons.search)),
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
        Align(
          alignment: Alignment.center,
          child: Text(
            "Mesin yang sedang digunakan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
        Align(
          alignment: Alignment.center,
          child: Text(
            "Produksi saat ini",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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