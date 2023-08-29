import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'laporanpengaturanproduk_view.dart';
import 'laporanproduksi_view.dart';
import 'home_view.dart';

void main() {
  runApp(MaterialApp(
    home: LaporanView(),
  ));
}

class LaporanView extends StatefulWidget {
  const LaporanView({Key? key}) : super(key: key);
  @override
  State<LaporanView> createState() => _LaporanViewState();
}

class _LaporanViewState extends State<LaporanView> {
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
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
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
                        SizedBox(width: 16),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                "Produksi",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.search),
                        suffixIconConstraints: BoxConstraints(minWidth: 40),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      children: [
                        DashboardMenuItem(
                          imageAsset: 'assets/icon.operator.png',
                          label: 'Pengaturan Produk',
                          onPressed: () {
                            Get.to(() => PengaturanProdukView());
                          },
                        ),
                        DashboardMenuItem(
                          imageAsset: 'assets/icon.audit.png',
                          label: 'Produksi',
                          onPressed: () {
                            Get.to(() => ProduksiView());
                          },
                        ),
                        DashboardMenuItem(
                          imageAsset: 'assets/icon.gudang.png',
                          label: 'Quality Control',
                          onPressed: () {
                            // Get.to(() => QcView());
                          },
                        ),
                        DashboardMenuItem(
                          imageAsset: 'assets/icon.qc.png',
                          label: 'Release',
                          onPressed: () {
                            // Get.to(() => ReleaseView());
                          },
                        ),
                        DashboardMenuItem(
                          imageAsset: 'assets/icon.monitor.png',
                          label: 'Logbook',
                          onPressed: () {
                            // Get.to(() => LogbookView());
                          },
                        ),
                        DashboardMenuItem(
                          imageAsset: 'assets/icon.tracker.png',
                          label: 'Laporan Hasil Produksi',
                          onPressed: () {
                            // Get.to(() => LaporanHasilView());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardMenuItem extends StatelessWidget {
  final String imageAsset;
  final String label;
  final VoidCallback onPressed;

  const DashboardMenuItem({
    required this.imageAsset,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageAsset,
            width: 52, 
            height: 52,
          ),
          SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Color(0xFF226EA4),
            ),
          ),
        ],
      ),
    );
  }
}