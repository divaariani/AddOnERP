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
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: 360,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.99, -0.14),
                end: Alignment(-0.99, 0.14),
                colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
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
                                    builder: (context) => const HomeView()),
                              );
                            },
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Customer Tracker",
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
                  const SizedBox(height: 20),
                  Visibility(
                    visible: true,
                    child: Center(
                      child: Image.asset(
                        "assets/delivery.png",
                        width: 350,
                        height: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
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
                  Padding(
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
                  const SizedBox(
                    height: 5,
                  ),
                  Stepper(
                    steps: [
                      Step(
                        title: Text(
                          'Order Placed',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFAFAFA)),
                        ),
                        content: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Text(
                              "This is step 4 content",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: const Color(0xff084D88)),
                            ),
                          ),
                        ),
                      ),
                      Step(
                        title: Text(
                          'Order Placed',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFAFAFA)),
                        ),
                        content: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Text(
                              "This is step 4 content",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: const Color(0xff084D88)),
                            ),
                          ),
                        ),
                      ),
                      Step(
                        title: Text(
                          'Order Placed',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFAFAFA)),
                        ),
                        content: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Text(
                              "This is step 4 content",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: const Color(0xff084D88)),
                            ),
                          ),
                        ),
                      ),
                      Step(
                        title: Text(
                          'Order Placed',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xffFAFAFA)),
                        ),
                        content: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Text(
                              "This is step 4 content",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: const Color(0xff084D88)),
                            ),
                          ),
                        ),
                      ),
                    ],
                    onStepTapped: (int newIndex) {
                      setState(() {
                        _currentStep = newIndex;
                      });
                    },
                    currentStep: _currentStep,
                    onStepContinue: () {
                      if (_currentStep != 3) {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                    },
                    onStepCancel: () {
                      if (_currentStep != 3) {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                    },
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