import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'home_view.dart';
import 'operatorstatus_view.dart';
import '../utils/globals.dart';
import '../utils/sessionmanager.dart';
import '../utils/app_colors.dart';
import '../controllers/response_model.dart';
import '../controllers/notification_controller.dart';
import '../controllers/machine_controller.dart';

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
  String _machineName = '';

  Future<void> fetchUserId() async {
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

  Future<void> fetchMachineData() async {
    try {
      final Map<String, dynamic> apiData = await MachineController.getWorkcenterList();
      final List<dynamic> dataList = apiData['data'];

      for (var item in dataList) {
        if (item['id'] == barcodeMachineResult.toString()) {
          _machineName = item['name'];
          break;
        }
      }

      setState(() {
        _machineName;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserId();
    fetchMachineData();
    fetchCurrentTime();
    currentTime = DateTime.now();
    idwcController.text = barcodeMachineResult;
  }

  Future<void> _submitForm() async {
    final int idwc = int.parse(idwcController.text);
    final int userId = int.parse(userIdLogin);
    final String tap = tapController.text;
    final String date = DateFormat('yyyy-MM-dd HH:mm').format(currentTime);

    try {
      await fetchCurrentTime();

      ResponseModel response = await MachineController.postOperatorInOut(
        idwc: idwc,
        userId: userId,
        oprTap: currentTime.toString(),
        tap: tap,
      );

      if (response.status == 1) {
        if (tap == "I") {
          Get.snackbar('IN Mesin', 'Operator $userName');
          try {
            await NotificationController.postNotification(
              userid: userId,
              title: 'Presensi',
              description: 'Anda telah IN mesin $_machineName',
              date: date,
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Terjadi kesalahan saat mengirim notifikasi: $e'),
              ),
            );
          }

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
          try {
            await NotificationController.postNotification(
              userid: userId,
              title: 'Presensi',
              description: 'Anda telah OUT mesin $_machineName',
              date: date,
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Terjadi kesalahan saat mengirim notifikasi: $e'),
              ),
            );
          }

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
                  colors: [AppColors.blueTwo, AppColors.blueThree],
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
                          color: AppColors.white,
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
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
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border: Border.all(
                                            color: AppColors.blueOne,
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
                                              color: AppColors.blueOne,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Mesin:',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.blueOne,
                                                ),
                                              ),
                                              Text(
                                                _machineName.length <= 10
                                                    ? _machineName
                                                    : _machineName.substring(0, 10) + '-',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColors.blueOne,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              if (_machineName.length > 10)
                                                Text(
                                                  _machineName.substring(10),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    color: AppColors.blueOne,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
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
                                primary: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                        color: AppColors.blueOne,
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
                                                color: AppColors.blueOne,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.greyThree,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Tidak',
                                                    style: TextStyle(
                                                      color: AppColors.blueOne,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    tapController.text = "O";
                                                    _submitForm();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.blueOne,
                                                    elevation: 0,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Ya',
                                                    style: TextStyle(
                                                      color: AppColors.white,
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
                                primary: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                        color: AppColors.blueOne,
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
                backgroundColor: AppColors.blueTwo,
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
                    color: AppColors.white,
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
