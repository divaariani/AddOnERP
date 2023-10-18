import 'package:flutter/material.dart';
import 'dart:async';
import 'gudanghasil_view.dart';


class RefreshGudangTable extends StatefulWidget {
  RefreshGudangTable({Key? key}) : super(key: key);

  @override
  _RefreshGudangTableState createState() => _RefreshGudangTableState();
}

class _RefreshGudangTableState extends State<RefreshGudangTable> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GudangHasilView(),
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