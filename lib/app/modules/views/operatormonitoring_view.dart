import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class OperatorMonitorView extends StatelessWidget {
  const OperatorMonitorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.99, -0.14),
              end: Alignment(-0.99, 0.14),
              colors: [AppColors.blueTwo, AppColors.blueThree],
            ),
          ),
        ),
        title: Text(
          'Monitoring',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
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
      body: const WebView(
        initialUrl: 'https://bierp.sutrakabel.com/#/monitoring-machine',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
