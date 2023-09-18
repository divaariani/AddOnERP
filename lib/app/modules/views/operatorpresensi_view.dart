import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import 'operatorstatus_view.dart';
import '../utils/globals.dart';
import '../utils/sessionmanager.dart';
import '../controllers/absensi_controller.dart';
import '../controllers/response_model.dart';

class OperatorPresensiView extends StatefulWidget {
  final String barcodeResult;

  const OperatorPresensiView({Key? key, required this.barcodeResult})
      : super(key: key);

  @override
  State<OperatorPresensiView> createState() => _OperatorPresensiViewState();
}

class _OperatorPresensiViewState extends State<OperatorPresensiView> {
  late DateTime currentTime;
  final idwcController = TextEditingController();
  final tapController = TextEditingController();

  final SessionManager sessionManager = SessionManager();
  final SessionManager _sessionManager = SessionManager();
  String userIdLogin = "";
  String userName = "";
  String userPhoto = "";
  String barcodeMachineResult = globalBarcodeResult;

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
          Get.snackbar('IN Mesin', 'Operator '+ userName);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return OperatorStatusView();
              },
            ),
          );
        } else if (tap == "O") {
          Get.snackbar('OUT Mesin', 'Operator '+ userName);
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
          SnackBar(
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
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        },
                        child: Image.asset('assets/icon.back.png',
                            width: 60, height: 60),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "Presensi",
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
                  Center(
                    child: Container(
                      height: 300,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/logo.png",
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(height: 30),
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
                                        color: Colors.blue[900]!,
                                        style: BorderStyle.solid,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 40),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF226EA4),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Id: " + userIdLogin,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        idwcController.text,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
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
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          margin: EdgeInsets.only(right: 20),
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
                              padding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.meeting_room,
                                      color: Color(0xFF226EA4)),
                                  SizedBox(width: 10),
                                  Text(
                                    "IN",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF226EA4),
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
                              tapController.text = "O";
                              _submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.meeting_room_outlined,
                                      color: Color(0xFF226EA4)),
                                  SizedBox(width: 10),
                                  Text(
                                    "OUT",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF226EA4),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
