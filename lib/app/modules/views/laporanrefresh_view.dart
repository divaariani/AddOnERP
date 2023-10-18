import 'package:flutter/material.dart';
import 'dart:async';
import 'audit_view.dart';
import 'laporanhasil_view.dart';


class RefreshLaporanTable extends StatefulWidget {
  RefreshLaporanTable({Key? key}) : super(key: key);

  @override
  _RefreshLaporanTableState createState() => _RefreshLaporanTableState();
}

class _RefreshLaporanTableState extends State<RefreshLaporanTable> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LaporanHasilView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)], 
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white), 
          ),
        ),
      ),
    );
  }
}