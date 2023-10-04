import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import 'operatorstatus_view.dart';
import '../utils/globals.dart';
import '../utils/sessionmanager.dart';
import '../controllers/absensi_controller.dart';
import '../controllers/response_model.dart';

class OperatorPresensiView extends StatefulWidget {
  final String barcodeMachineResult;

  const OperatorPresensiView({Key? key, required this.barcodeMachineResult}) : super(key: key);

  @override
  State<OperatorPresensiView> createState() => _OperatorPresensiViewState();
}

class _OperatorPresensiViewState extends State<OperatorPresensiView> {
  late DateTime currentTime;
  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  final idwcController = TextEditingController();
  final tapController = TextEditingController();
  String userIdLogin = "";
  String userName = "";
  String userPhoto = "";
  String barcodeMachineResult = globalBarcodeMesinResult;

  Future<void> _fetchUserId() async {
    userIdLogin = await _sessionManager.getUserId() ?? "";
    userName = await _sessionManager.getUsername() ?? "";
    userPhoto = await _sessionManager.getUserProfile() ?? "";
    setState(() {});
  }

  Future<void> fetchCurrentTime() async {
    try {
      setState(() {
        currentTime = DateTime.now();
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserId();
    currentTime = DateTime.now();
    idwcController.text = barcodeMachineResult;
  }

  Future<void> _submitForm() async {
    final int idwc = int.parse(idwcController.text);
    final int userId = int.parse(userIdLogin);
    final String tap = tapController.text;

    try {
      await fetchCurrentTime();

      ResponseModel response = await AbsensiController.postFormData(
        idwc: idwc,
        userId: userId,
        oprTap: currentTime.toString(),
        tap: tap,
      );

      if (response.status == 1) {
        if (tap == "I") {
          Get.snackbar('IN Mesin', 'Operator $userName');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return OperatorStatusView();
              },
            ),
          );
        } else if (tap == "O") {
          Get.snackbar('OUT Mesin', 'Operator $userName');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return HomeView();
              },
            ),
          );
        }
      } else if (response.status == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Request gagal: ${response.message}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan: Response tidak valid.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
        ),
      );
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
                    Center(
                      child: Container(
                        height: 250,
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: const Color(0xFFFAFAFA),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/logo.png",
                                  width: 70,
                                  height: 70,
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(userPhoto),
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                          color: const Color(0xFF084D88),
                                          style: BorderStyle.solid,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF084D88),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Kode Mesin: '+ idwcController.text,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF084D88),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            margin: const EdgeInsets.only(right: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                tapController.text = "I";
                                _submitForm();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icon.in.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "IN",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF084D88),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Image.asset(
                                                'assets/icon.warning.png',
                                                width: 70,
                                                height: 70,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Apakah Anda telah selesai menggunakan mesin?',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: const Color(0xFF084D88),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffD1D3D9),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Tidak',
                                                    style: TextStyle(
                                                      color: Color(0xFF084D88),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    tapController.text = "O";
                                                    _submitForm();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF084D88),
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Ya',
                                                    style: TextStyle(
                                                      color: Color(0xFFFAFAFA),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icon.out.png',
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "OUT",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xFF084D88),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                  "Presensi",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFAFAFA),
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
