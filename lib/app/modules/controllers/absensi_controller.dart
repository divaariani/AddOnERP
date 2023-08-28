import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AbsensiController extends GetxController {
  RxString isIdWorkCenter = ''.obs;
  RxString isId = ''.obs;
  RxString isInOrOut = ''.obs;

  Future<void> fetchUserData() async {
    try {
      final response = await http.post(
        Uri.parse('{YOUR API}'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var responseData = data[0];
        isIdWorkCenter.value = responseData['idwc'];
        isId.value = responseData['userid'];
        isInOrOut.value = responseData['tap'];
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}