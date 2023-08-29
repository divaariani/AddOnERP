import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_view.dart';

void main() {
  runApp(MaterialApp(
      //home: OperatorStatusView(),
      ));
}

class OperatorStatusView extends StatefulWidget {
  const OperatorStatusView({Key? key}) : super(key: key);
  @override
  State<OperatorStatusView> createState() => _OperatorStatusViewState();
}

class _OperatorStatusViewState extends State<OperatorStatusView> {
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
                            "Status Mesin",
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
                  CardTable(),
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
          color: Color.fromARGB(150, 255, 255, 255)!,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Monitoring Mesin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
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
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(2.5),
                  },
                  border: TableBorder.all(color: Colors.black),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            'Mesin',
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
                            'Operator',
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
                            'Aksi',
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
                          child: Center(
                              child: Text('Draw-A', style: tableCellnew)),
                        ),
                        TableCell(
                          child:
                              Center(child: Text('Bayu', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // on tap logic here
                                  },
                                  child: Image.asset(
                                    'assets/icon.start.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 10, height: 10),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Color(0xFF084D88),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Pause',
                                                  style: TextStyle(
                                                    color: Color(0xFFD9D9D9),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9), 
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Naik WIP',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Set Up Mesin',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Naik Bobin',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Pergi/Istirahat',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Lingkungan',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        print(value);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/icon.pause.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Color(0xFF084D88),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Blocked',
                                                  style: TextStyle(
                                                    color: Color(0xFFD9D9D9),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9), 
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Material Availability',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Equipment Failure',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Setup and Adjustments',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Reduced Speed',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Process Defect',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Reduced Yield',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Fully Productive Time',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        print(value);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/icon.block.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    // on tap logic here
                                  },
                                  child: Image.asset(
                                    'assets/icon.end.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text('Draw-B', style: tableCellnew)),
                        ),
                        TableCell(
                          child:
                              Center(child: Text('Rizki', style: tableCellnew)),
                        ),
                        TableCell(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // on tap logic here
                                  },
                                  child: Image.asset(
                                    'assets/icon.start.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 10, height: 10),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Color(0xFF084D88),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Pause',
                                                  style: TextStyle(
                                                    color: Color(0xFFD9D9D9),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9), 
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Naik WIP',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Set Up Mesin',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Naik Bobin',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Pergi/Istirahat',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Lingkungan',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        print(value);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/icon.pause.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor: Color(0xFF084D88),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Blocked',
                                                  style: TextStyle(
                                                    color: Color(0xFFD9D9D9),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 20),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9), 
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Material Availability',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Equipment Failure',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Setup and Adjustments',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Reduced Speed',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Process Defect',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Reduced Yield',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: Color(0xFFD9D9D9),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      // onpressed logic
                                                    },
                                                    child: Text(
                                                      'Fully Productive Time',
                                                      style: TextStyle(
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        print(value);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'assets/icon.block.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    // on tap logic here
                                  },
                                  child: Image.asset(
                                    'assets/icon.end.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ],
                            ),
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