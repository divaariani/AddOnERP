import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'actor_controller.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../utils/sessionmanager.dart';
import '../utils/globals.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var userID = ''.obs;

  SessionManager sessionManager = SessionManager();

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
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Email and password must be filled');
      return;
    }

    loading.value = true;
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      loading.value = false;
      Get.snackbar('No Internet Connection', 'Please check your internet connection.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('{API}'),
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

        String userToken = data['data']['token'];

        await sessionManager.clearAuthToken();
        await sessionManager.setLoggedIn(true);
        await sessionManager.setUserId(profileId.value);
        await sessionManager.setUsername(profileName.value);
        await sessionManager.setAuthToken(userToken);
        await sessionManager.setUserProfile(profilePhotoUrl.value);

        ActorController actorController = Get.put(ActorController());
        await actorController.fetchUserData();

        Get.to(() => const HomeView());
      } else {
        loading.value = false;
        if (data.containsKey('error')) {
          Get.snackbar('Login Failed', data['error']);
        } else {
          Get.snackbar('Login Failed', 'Account not registered.');
        }
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Exception', e.toString());
    }
  }

  void clearGlobalBarcodeResult() {
    setGlobalBarcodeResult(''); 
  }

  void logout() {
    final SessionManager sessionManager = SessionManager();
    sessionManager.clearAuthToken();
    sessionManager.setLoggedIn(false);
    Get.offAll(() => const LoginView());
    clearGlobalBarcodeResult();
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
