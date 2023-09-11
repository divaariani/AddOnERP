import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OperatorMonitorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.99, -0.14),
              end: Alignment(-0.99, 0.14),
              colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)],
            ),
          ),
        ),
        title: Text(
          'Monitoring',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset(
            'assets/icon.back.png',
          ),
        ),
      ),
      body: WebView(
        initialUrl: 'https://bierp.sutrakabel.com/#/monitoring-machine',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
