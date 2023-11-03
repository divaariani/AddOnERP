
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'home_view.dart';
import 'scancustomer_view.dart';
import '../controllers/customer_controller.dart';
import '../utils/service.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({Key? key}) : super(key: key);

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView>
    with TickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();
  bool isvisible = true;
  double borderwidth = 1.0;
  late final AnimationController _controller;
  bool isAnimationStarted = false;

  int noStage = 8;
  final customerController = Get.put(CustomerController(customerService: CustomerService()));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    controller.dispose();
    _controller.dispose(); // Hapus pengontrol animasi saat widget dihapus
    super.dispose();
  }

  void _onTextChanged() {
    if (controller.text.isNotEmpty && !isAnimationStarted) {
      _controller.forward();
      setState(() {
        isAnimationStarted = true;
      });
    } else if (controller.text.isEmpty) {
      _controller.reset();
      setState(() {
        isAnimationStarted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
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
              decoration: const BoxDecoration(
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
                    const SizedBox(height: 70),
                    AnimatedContainer(
                      padding:
                          EdgeInsets.symmetric(vertical: isvisible ? 20 : 0),
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: Lottie.asset(
                          'assets/lottie2.json',
                          width: 200,
                          repeat: true,
                          fit: BoxFit.cover,
                          controller:
                              _controller, // Hubungkan controller di sini
                          onLoaded: (composition) {
                            _controller
                              ..duration = composition.duration
                              ..forward(); // Mulai animasi
                          },
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
                                      onSubmitted: (value) async {
                                        await customerController
                                            .getData(controller.text);
                                        setState(() {
                                          isvisible = false;
                                          borderwidth = 0.0;
                                          isAnimationStarted =
                                              true; // Set ke true ketika teks dikirim
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
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScanCustomerView() 
                                    ),
                              );
                              if (customerController
                                  .valueFromBarcode.isNotEmpty) {
                                await customerController.getData(
                                    customerController.valueFromBarcode.value);
                              }
                              setState(() {
                                isvisible = false;
                                borderwidth = 0.0;
                                isAnimationStarted =
                                    true; // Set ke true ketika teks dikirim
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.asset(
                                "assets/barcode.png",
                                color: const Color(0xFF084D88),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Obx(() {
                      if (customerController.data.isNotEmpty) {
                        final customerData = customerController.data[0];
                        final namaBarang = customerData.namabarang;
                        final kuantitas = customerData.qtyorder;
                        return Column(
                          children: [
                            // Tampilan lain di atas
                            Visibility(
                              visible: !isvisible,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  color: const Color(0xffFAFAFA),
                                  child: Container(
                                    height: 100,
                                    width:
                                        1 * MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Nama Barang : ',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff084D88),
                                                ),
                                              ),
                                              TextSpan(
                                                text: namaBarang,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff084D88),
                                                ),
                                              ),
                                              const TextSpan(text: '\n'),
                                              const TextSpan(
                                                text: 'Kuantitas : ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff084D88),
                                                ),
                                              ),
                                              TextSpan(
                                                text: kuantitas,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff084D88),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Tampilan lain di bawah
                          ],
                        );
                      }
                      return const SizedBox();
                    }),

                    // Visibility(
                    //   visible: !isvisible,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(15),
                    //     child: Card(
                    //       elevation: 5,
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(15)),
                    //       color: const Color(0xffFAFAFA),
                    //       child: Container(
                    //         height: 100,
                    //         width: 1 * MediaQuery.of(context).size.width,
                    //         padding: const EdgeInsets.only(left: 10, top: 10),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             RichText(
                    //               text: TextSpan(
                    //                 children: <TextSpan>[
                    //                   TextSpan(
                    //                     text: 'Nama Barang : ',
                    //                     style: GoogleFonts.poppins(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight
                    //                           .bold, // Make this part bold
                    //                       color: const Color(0xff084D88),
                    //                     ),
                    //                   ),
                    //                   const TextSpan(
                    //                     text:
                    //                         '[M10015-Trial] NYFGbY-FR (CU/PVC/SFA/PVC-FR) 3x10mm2 0.6/1 (1.2)kV rm',
                    //                     style: TextStyle(
                    //                       fontSize: 14,
                    //                       color: Color(0xff084D88),
                    //                     ),
                    //                   ),
                    //                   const TextSpan(text: '\n'),
                    //                   const TextSpan(
                    //                     text: 'Kuantitas : ',
                    //                     style: TextStyle(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: Color(0xff084D88),
                    //                     ),
                    //                   ),
                    //                   const TextSpan(
                    //                     text: '500',
                    //                     style: TextStyle(
                    //                       fontSize: 14,
                    //                       color: Color(0xff084D88),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             )

                    //             // Text(
                    //             //   "Nama Barang : [M10015-Trial] NYFGbY-FR (CU/PVC/SFA/PVC-FR) 3x10mm2 0.6/1 (1.2)kV rm",
                    //             //   style: GoogleFonts.poppins(
                    //             //     fontSize: 14,
                    //             //     color: const Color(0xff084D88),
                    //             //   ),
                    //             // ),
                    //             // const SizedBox(
                    //             //   height: 5,
                    //             // ),
                    //             // Text(
                    //             //   "Kuantitas : ",
                    //             //   style: GoogleFonts.poppins(
                    //             //       fontSize: 14,
                    //             //       color: const Color(0xff084D88)),
                    //             // )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
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
                    Obx(() {
                      if (customerController.data.isNotEmpty) {
                        List<bool> resultStatus = [];
                        int noStage =
                            int.parse(customerController.data[0].noStage);
                        for (var i = 1; i <= noStage; i++) {
                          resultStatus.add(true);
                        }
                        for (var i = noStage + 1; i <= 10; i++) {
                          resultStatus.add(false);
                        }

                        print(resultStatus);

                        return Visibility(
                          visible: !isvisible,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                resultStatus[0] == true
                                    ? const TimeLineActiveWidget(
                                        isFirst: true,
                                        title: 'Confirmation Order',
                                        subtitle: "Sunday, October 1, 2023",
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'Confirmation Order',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[1] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'Job Order',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'Job Order',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[2] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'Production Planning',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'Production Planning',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[3] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'WIP Proses',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'WIP Proses',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[4] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'QC Checking',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'QC Checking',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[5] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'Product Received',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'Warehous Occupation',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[6] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'Delivery Order Created',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'Delivery Order Created',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[7] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'Warehouse Picking',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'Warehouse Picking',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[8] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'On Expedition Delivery',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'On Expedition Delivery',
                                        subtitle: 'Sunday, October 1, 2023',
                                      ),
                                resultStatus[9] == true
                                    ? const TimeLineActiveWidget(
                                        title: 'Product Received',
                                        subtitle: 'Sunday, October 1, 2023',
                                      )
                                    : const TimeLinePasiveWidget(
                                        title: 'Product Received',
                                        subtitle: 'Sunday, October 1, 2023',
                                        isLast: true,
                                      ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: const Color(0xFF2A77AC),
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: const Text(
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

class TimeLineActiveWidget extends StatelessWidget {
  final bool isFirst;

  final bool isLast;
  final String title;
  final String subtitle;

  const TimeLineActiveWidget({
    super.key,
    this.isFirst = false,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      afterLineStyle: const LineStyle(
        color: Color(0xffFAFAFA),
        thickness: 6,
      ),
      alignment: TimelineAlign.start,
      isFirst: isFirst,
      isLast: isLast,

      indicatorStyle: IndicatorStyle(
        width: 24,
        color: const Color(0xffFAFAFA),
        iconStyle: IconStyle(
          fontSize: 20,
          color: const Color(0xff084D88),
          iconData: Icons.check,
        ),
      ),
      beforeLineStyle: isFirst
          ? const LineStyle()
          : const LineStyle(
              color: Color(0xffFAFAFA),
              thickness: 6,
            ),
      endChild: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16, top: 30),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                color: const Color(0xff084D88),
                fontWeight: FontWeight.w700,
                height: 22 / 14,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xff084D88),
                height: 22 / 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimeLinePasiveWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final String subtitle;

  const TimeLinePasiveWidget({
    super.key,
    this.isFirst = false,
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      afterLineStyle: LineStyle(
        color: const Color(0xffFAFAFA).withOpacity(0.5),
        thickness: 6,
      ),
      alignment: TimelineAlign.start,

      indicatorStyle: IndicatorStyle(
        width: 24,
        color: const Color(0xffFAFAFA).withOpacity(0.5),
      ),
      beforeLineStyle: LineStyle(
        color: const Color(0xffFAFAFA).withOpacity(0.5),
        thickness: 6,
      ),

      isLast: isLast,
      isFirst: isFirst,
      endChild: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16, top: 30),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                color: const Color(0xff084D88),
                fontWeight: FontWeight.w700,
                height: 22 / 14,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xff084D88),
                height: 22 / 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}