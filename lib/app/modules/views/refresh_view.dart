import 'package:flutter/material.dart';
import 'dart:async';
import 'audit_view.dart';
import 'audithasil_view.dart';
import 'laporanhasil_view.dart';
import 'gudanghasil_view.dart';


class RefreshAuditor extends StatefulWidget {
  RefreshAuditor({Key? key}) : super(key: key);

  @override
  _RefreshAuditorState createState() => _RefreshAuditorState();


}

class _RefreshAuditorState extends State<RefreshAuditor> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuditView(),
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

class RefreshAuditTable extends StatefulWidget {
  RefreshAuditTable({Key? key}) : super(key: key);

  @override
  _RefreshAuditTableState createState() => _RefreshAuditTableState();
}

class _RefreshAuditTableState extends State<RefreshAuditTable> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuditHasilView(),
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
