import 'package:get/get.dart';
import '../utils/model.dart';
import '../utils/service.dart';

class CustomerController extends GetxController {
  CustomerService customerService;
  CustomerController({required this.customerService});

  RxList<CustomerModel> data = <CustomerModel>[].obs;

  Future<void> getData(String nomor) async {
    final result = await customerService.getDataCustomer(nomor);

    data.value = result;
  }

  RxString valueFromBarcode = ''.obs;
}