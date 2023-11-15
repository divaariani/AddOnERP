import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/sessionmanager.dart';
import '../utils/globals.dart';
        
class ActorController extends GetxController {
  final SessionManager sessionManager = SessionManager();

  RxString isAdmin = ''.obs;
  RxString isOperator = ''.obs;
  RxString isWarehouse = ''.obs;
  RxString isAuditor = ''.obs;
  RxString isQC = ''.obs;
  RxString isCustomer = ''.obs;
  RxString isMonitor = ''.obs;
  RxBool loading = true.obs; 

  Future<void> fetchUserData() async {
    try {
      final String? userId = await sessionManager.getUserId();      
      final response = await http.post(
        Uri.parse('$apiBaseUrl?function=get_user_id&id=$userId'),
        headers: {'Contentri-Type': 'application/json; charset=UTF-8'},
      );
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var responseData = data['data'][0];
        isAdmin.value = responseData['user_admin'];
        isOperator.value = responseData['user_operator'];
        isWarehouse.value = responseData['user_warehouse'];
        isAuditor.value = responseData['user_auditor'];
        isQC.value = responseData['user_qc'];
        isCustomer.value = responseData['user_customer'];
        isMonitor.value = responseData['user_monitor'];
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    } finally {
      loading.value = false; 
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
