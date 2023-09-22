import 'package:addon/app/modules/components/timeline_active_widget.dart';
import 'package:addon/app/modules/components/timeline_passive_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_view.dart';

void main() {
  runApp(const MaterialApp(
    home: CustomerView(),
  ));
}

class CustomerView extends StatefulWidget {
  const CustomerView({Key? key}) : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  bool isvisible = true;
  final TextEditingController controller = TextEditingController();
  double borderwidth = 1.0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: 360,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    AnimatedContainer(
                      padding:
                          EdgeInsets.symmetric(vertical: isvisible ? 20 : 0),
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: Image.asset(
                          'assets/delivery.png',
                          width: 350,
                          height: 200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                border:
                                    Border.all(color: const Color(0xFF084D88)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: controller,
                                      onSubmitted: (value) {
                                        setState(() {
                                          isvisible = false;
                                          borderwidth = 0.0;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Masukkan Nomor Order',
                                          hintStyle: GoogleFonts.poppins(
                                              color: const Color(0xff084D88),
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: SizedBox(
                                      height: 50,
                                      width: 30,
                                      child: Image.asset("assets/search.png"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/barcode.png",
                                color: const Color(0xFF084D88)),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !isvisible,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: const Color(0xffFAFAFA),
                          child: Container(
                            height: 100,
                            width: 1 * MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ID Customer : John Doe",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff084D88)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Detail Pesanan : ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff084D88)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: !isvisible,
                      child: Center(
                        child: Text(
                          "Status Pesanan",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFAFAFA)),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !isvisible,
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TimeLineActiveWidget(
                              isFirst: true,
                              title: 'Dibayar',
                              subtitle: "we have received your order",
                            ),
                            TimeLinePasiveWidget(
                                title: 'Diproses',
                                subtitle: 'we have received your order'),
                            TimeLinePasiveWidget(
                                title: 'Dikirim',
                                subtitle: 'we have received your order'),
                            TimeLinePasiveWidget(
                              title: 'Diterima',
                              subtitle: 'we have received your order',
                              isLast: true,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Color(0xFF2A77AC),
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: Text(
                  "Customer Tracker",
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
      ),
    );
  }
}
