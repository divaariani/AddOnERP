import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utils/globals.dart';
import 'audit_view.dart';

void main() {
  runApp(MaterialApp(
    home: AuditIsiView(onSaveText: (String textToSave) {
      print('Saved: $textToSave');
    }),
  ));
}

class AuditIsiView extends StatefulWidget {
  final ValueChanged<String> onSaveText;

  const AuditIsiView({Key? key, required this.onSaveText}) : super(key: key);

  @override
  State<AuditIsiView> createState() => _AuditIsiViewState();
}

class _AuditIsiViewState extends State<AuditIsiView> {

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
                                    builder: (context) => AuditView()),
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
                            "Isi Auditor",
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
                      width: 1 * MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Nama: ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue[900],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Auditor_' + globalName + "_" + DateFormat('ddMMyy').format(DateTime.now()),
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue[900],
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'State: ',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Draft",
                                  style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text("Date: ",
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                                Text(
                                    DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text("Company: ",
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                                Text("Auditor",
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            String textToSave = 'Auditor_' + globalName + "_" + DateFormat('ddMMyy').format(DateTime.now());
                            widget.onSaveText(textToSave);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuditView(),
                                settings: RouteSettings(arguments: textToSave),
                              ),
                            );
                          },
                          icon: Icon(Icons.save_alt, size: 20),
                          label: Text('Simpan', style: TextStyle(fontSize: 14)),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(8, 77, 136, 136),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            minimumSize: Size(120, 60),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}