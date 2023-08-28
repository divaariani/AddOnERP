import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'laporan_view.dart';

void main() {
  runApp(MaterialApp(
    home: PengaturanProdukView(),
  ));
}

class PengaturanProdukView extends StatefulWidget {
  const PengaturanProdukView({Key? key}) : super(key: key);
  @override
  State<PengaturanProdukView> createState() => _PengaturanProdukViewState();
}

class _PengaturanProdukViewState extends State<PengaturanProdukView> {
  List<String> items = [
    "Jenis Produk",
    "Produk",
  ];
  List<IconData> icons = [
    Icons.home,
    Icons.explore,
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    builder: (context) => LaporanView()),
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
                            "Produk",
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
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: items.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        current = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.all(5),
                                      width: 110,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: current == index
                                            ? Colors.blue[900]
                                            : Colors.lightBlue,
                                        borderRadius: current == index
                                            ? BorderRadius.circular(15)
                                            : BorderRadius.circular(10),
                                        border: current == index
                                            ? Border.all(
                                                color: Colors.white,
                                                width: 2)
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          items[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.laila(
                                              fontWeight: FontWeight.w500,
                                              color: current == index
                                                  ? Colors.white
                                                  : Colors.blue[900]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: current == index,
                                      child: Container(
                                        width: 5,
                                        height: 5,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                      ))
                                ],
                              );
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        width: double.infinity,
                        height: 550,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[current],
                              size: 200,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              items[current],
                              style: GoogleFonts.laila(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
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
