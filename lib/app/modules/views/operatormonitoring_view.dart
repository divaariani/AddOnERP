import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OperatorMonitorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring'),
      ),
      body: WebView(
        initialUrl: 'https://bierp.sutrakabel.com/#/monitoring-machine', 
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}