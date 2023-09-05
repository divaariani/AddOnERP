import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import 'operatorstatus_view.dart';
import '../utils/globals.dart';
import '../controllers/absensi_controller.dart';
import '../controllers/login_controller.dart';
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

  final LoginController _loginController = Get.find<LoginController>();
  final userIdController = TextEditingController();
  final idwcController = TextEditingController();
  final tapController = TextEditingController();

  String profileId = globalID.toString();
  String barcodeMachineResult = globalBarcodeResult;

  @override
  void initState() {
    super.initState();
    currentTime = DateTime.now();
    userIdController.text = profileId;
    idwcController.text = barcodeMachineResult;
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

  Future<void> _submitForm() async {
    final int idwc = int.parse(idwcController.text);
    final int userId = int.parse(userIdController.text);
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
          Get.snackbar('IN Mesin', 'Operator '+_loginController.profileName.value);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return OperatorStatusView();
              },
            ),
          );
        } else if (tap == "O") {
          Get.snackbar('OUT Mesin', 'Operator '+_loginController.profileName.value);
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
                                    builder: (context) => HomeView()),
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
                                        image: NetworkImage(_loginController
                                            .profilePhotoUrl.value),
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
                                        _loginController.profileName.value,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF226EA4),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Id: " + userIdController.text,
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