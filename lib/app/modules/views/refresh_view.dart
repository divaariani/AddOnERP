import 'package:flutter/material.dart';
import 'dart:async';
import 'audit_view.dart';
import 'audithasil_view.dart';
import 'laporanhasil_view.dart';
import 'gudangout_view.dart';
import 'gudangin_view.dart';
import '../utils/app_colors.dart';

class RefreshAuditor extends StatefulWidget {
  const RefreshAuditor({Key? key}) : super(key: key);

  @override
  State<RefreshAuditor> createState() => _RefreshAuditorState();
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
            colors: [AppColors.blueTwo, AppColors.blueThree], 
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white), 
          ),
        ),
      ),
    );
  }
}

class RefreshAuditTable extends StatefulWidget {
  const RefreshAuditTable({Key? key}) : super(key: key);

  @override
  State<RefreshAuditTable> createState () => _RefreshAuditTableState();
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
            colors: [AppColors.blueTwo, AppColors.blueThree], 
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white), 
          ),
        ),
      ),
    );
  }
}

class RefreshLaporanTable extends StatefulWidget {
  const RefreshLaporanTable({Key? key}) : super(key: key);

  @override
  State<RefreshLaporanTable> createState() => _RefreshLaporanTableState();
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
            colors: [AppColors.blueTwo, AppColors.blueThree], 
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white), 
          ),
        ),
      ),
    );
  }
}

class RefreshGudangTable extends StatefulWidget {
  const RefreshGudangTable({Key? key}) : super(key: key);

  @override
  State<RefreshGudangTable> createState() => _RefreshGudangTableState();
}

class _RefreshGudangTableState extends State<RefreshGudangTable> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GudangOutView(),
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
            colors: [AppColors.blueTwo, AppColors.blueThree], 
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white), 
          ),
        ),
      ),
    );
  }
}


class RefreshGudangInTable extends StatefulWidget {
  const RefreshGudangInTable({Key? key}) : super(key: key);

  @override
  State<RefreshGudangInTable> createState() => _RefreshGudangInTableState();
}

class _RefreshGudangInTableState extends State<RefreshGudangInTable> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GudangInView(),
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
            colors: [AppColors.blueTwo, AppColors.blueThree], 
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white), 
          ),
        ),
      ),
    );
  }
}
