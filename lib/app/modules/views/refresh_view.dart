import 'package:flutter/material.dart';
import 'dart:async';
import 'audit_view.dart';
import 'audithasil_view.dart';

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