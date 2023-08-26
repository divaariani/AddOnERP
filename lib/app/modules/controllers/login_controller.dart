import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:addon/app/modules/views/home_view.dart';
import 'package:http/http.dart' as http;
import 'actor_controller.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool loading = false.obs;
  RxBool loginSuccess = false.obs;
  RxString profileId = ''.obs;
  RxString profileName = ''.obs;
  RxString profilePhotoUrl = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void loginApi() async {
    loading.value = true;
    try {
      final response = await http.post(
        Uri.parse('{YOUR_API}'),
        body: jsonEncode({
          "params": {
            'email': emailController.text,
            'password': passwordController.text,
          }
        }),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      var data = jsonDecode(response.body);
      print(response.statusCode);
      print(data);
      print(response.body);

      if (response.statusCode == 200) {
        loading.value = false;
        Get.snackbar('Login Successful', 'Congratulations');

        var responseData = data['data']['user'];
        profileId.value = responseData['id'].toString();
        profileName.value = responseData['name'];
        profilePhotoUrl.value = responseData['avatar'];
        
        ActorController _actorController = Get.put(ActorController());
        await _actorController.fetchUserData();
        
        Get.to(() => HomeView());
      } else {
        loading.value = false;
        Get.snackbar('Login Failed', data['error']);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Exception', e.toString());
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}