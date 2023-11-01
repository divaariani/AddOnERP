import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'home_view.dart';
import '../controllers/machine_controller.dart';
import '../controllers/response_model.dart';
import '../controllers/notification_controller.dart';
import '../utils/sessionmanager.dart';
import '../utils/app_colors.dart';

class OperatorStatusView extends StatefulWidget {
  const OperatorStatusView({Key? key}) : super(key: key);

  @override
  State<OperatorStatusView> createState() => _OperatorStatusViewState();
}

class _OperatorStatusViewState extends State<OperatorStatusView> {
  List<MyData> _data = [];

  late DateTime currentTime;

  Future<void> fetchCurrentTime() async {
    try {
      setState(() {
        currentTime = DateTime.now();
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchDataFromAPI() async {
    try {
      final response = await MachineController.postFormOperator(
        id: 1,
        name: '',
        userId: 1,
        namaoperator: '',
        statusmesin: '',
      );

      final List<dynamic> nameDataList = response.data;

      final List<MyData> myDataList = nameDataList.map((data) {
        return MyData(
          id: data['id'] ?? '',
          mesin: data['name'] ?? '',
          operator: data['namaoperator'] ?? '',
          aksi: '',
          status: data['statusmesin'] ?? '',
        );
      }).toList();

      setState(() {
        _data = myDataList;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
    currentTime = DateTime.now();
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
                    CardTable(data: _data),
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
                  "Status Mesin",
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

class MyData {
  final String id;
  final String aksi;
  final String mesin;
  final String operator;
  final String status;

  MyData({
    required this.id,
    required this.aksi,
    required this.mesin,
    required this.operator,
    required this.status,
  });
}

class MyDataTableSource extends DataTableSource {
  final List<MyData> data;
  final BuildContext parentContext;
  MyDataTableSource(this.data, this.parentContext);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final entry = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(AksiCellWidget(
          parentContext: parentContext,
          entry: entry,
        )),
        DataCell(Text(
          entry.mesin,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )),
        DataCell(Text(
          entry.operator,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )),
        DataCell(Text(
          entry.status,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  void updateData(List<MyData> newData) {
    data.clear();
    data.addAll(newData);
  }
}

class CardTable extends StatefulWidget {
  final List<MyData> data;

  const CardTable({Key? key, required this.data}) : super(key: key);

  @override
  _CardTableState createState() => _CardTableState();
}

class _CardTableState extends State<CardTable> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  bool _isLoading = false;
  List<MyData> _data = [];

  Future<void> fetchDataFromAPI() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final response = await MachineController.postFormOperator(
        id: 1,
        name: '',
        userId: 1,
        namaoperator: '',
        statusmesin: '',
      );

      final List<dynamic> nameDataList = response.data;
      print('API Response: $nameDataList');

      final List<MyData> myDataList = nameDataList.map((data) {
        return MyData(
          id: data['id'] ?? '',
          mesin: data['name'] ?? '',
          operator: data['namaoperator'] ?? '',
          aksi: '',
          status: data['statusmesin'] ?? '',
        );
      }).toList();

      setState(() {
        _data = myDataList.where((data) {
          return data.mesin
                  .toLowerCase()
                  .contains(_searchResult.toLowerCase()) ||
              data.operator
                  .toLowerCase()
                  .contains(_searchResult.toLowerCase()) ||
              data.status.toLowerCase().contains(_searchResult.toLowerCase());
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(Icons.search),
              title: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Cari...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchResult = value;
                    fetchDataFromAPI();
                  });
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  setState(() {
                    controller.clear();
                    _searchResult = '';
                    fetchDataFromAPI();
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: PaginatedDataTable(
              columns: [
                DataColumn(
                  label: Flexible(
                    child: Text(
                      'Aksi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Flexible(
                    child: Text(
                      'Mesin',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Flexible(
                    child: Text(
                      'Operator',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Flexible(
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
              source: MyDataTableSource(_data, context),
              rowsPerPage: 10,
            ),
          ),
        ),
      ],
    );
  }
}

class AksiCellWidget extends StatefulWidget {
  final BuildContext parentContext;
  final MyData entry;
  const AksiCellWidget({Key? key, required this.parentContext, required this.entry}) : super(key: key);

  @override
  State<AksiCellWidget> createState() => _AksiCellWidgetState();
}

class _AksiCellWidgetState extends State<AksiCellWidget> {
  late DateTime currentTime;
  final SessionManager sessionManager = SessionManager();
  final stateController = TextEditingController();
  final idController = TextEditingController();
  String userIdLogin = "";

  Future<void> _fetchUserId() async {
    userIdLogin = await sessionManager.getUserId() ?? "";
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
    currentTime = DateTime.now();
    _fetchUserId();
  }

  Future<void> _submitState() async {
    final int id = int.parse(idController.text);
    final String state = stateController.text;
    final int userId = int.parse(userIdLogin);
    final String date = DateFormat('yyyy-MM-dd HH:mm').format(currentTime);

    try {
      await fetchCurrentTime();

      ResponseModel response = await MachineController.postFormMachineState(
        id: id,
        state: state,
        timestate: currentTime.toString(),
      );

      if (response.status == 1) {
        final machineName = widget.entry.mesin;

        if (state == "Start") {
          Get.snackbar('Mesin $machineName', 'started');
          try {
            await NotificationController.postNotification(
              userid: userId,
              title: 'Mesin',
              description: 'Anda melakukan start mesin $machineName',
              date: date,
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Terjadi kesalahan saat mengirim notifikasi: $e'),
              ),
            );
          }
        } else if (state == "Pause (Naik WIP)") {
          Get.snackbar('Mesin $machineName', 'paused');
        } else if (state == "Pause (Naik Bobin)") {
          Get.snackbar('Mesin $machineName', 'paused');
        } else if (state == "Pause (Setup Mesin)") {
          Get.snackbar('Mesin $machineName', 'paused');
        } else if (state == "Pause (Pergi/Istirahat)") {
          Get.snackbar('Mesin $machineName', 'paused');
        } else if (state == "Pause (Lingkungan)") {
          Get.snackbar('Mesin $machineName', 'paused');
        } else if (state == "Block (Material Availability)") {
          Get.snackbar('Mesin $machineName', 'blocked');
        } else if (state == "Block (Equiment Failure)") {
          Get.snackbar('Mesin $machineName', 'blocked');
        } else if (state == "Block (Setup Adjustments)") {
          Get.snackbar('Mesin $machineName', 'blocked');
        } else if (state == "Block (Reduced Speed)") {
          Get.snackbar('Mesin $machineName', 'blocked');
        } else if (state == "Block (Process Defect)") {
          Get.snackbar('Mesin $machineName', 'blocked');
        } else if (state == "Block (Reduced Yield)") {
          Get.snackbar('Mesin $machineName', 'blocked');
        } else if (state == "Block (Fully Productive Time)") {
          Get.snackbar('Mesin $machineName', 'blocked');
        } else if (state == "End") {
          Get.snackbar('Mesin $machineName', 'ended');
          try {
            await NotificationController.postNotification(
              userid: userId,
              title: 'Mesin',
              description: 'Anda melakukan end mesin $machineName',
              date: date,
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Terjadi kesalahan saat mengirim notifikasi: $e'),
              ),
            );
          }
        }

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const OperatorStatusView()));
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
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              final id = widget.entry.id;
              idController.text = id;
              stateController.text = "Start";
              _submitState();
            },
            child: Image.asset(
              'assets/icon.start.png',
              height: 25,
              width: 25,
            ),
          ),
          const SizedBox(width: 10, height: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: AppColors.blueOne,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Pause',
                              style: TextStyle(
                                color: AppColors.greyThree,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Naik WIP)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Naik WIP',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Setup Mesin)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Set Up Mesin',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Naik Bobin)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Naik Bobin',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Pause (Pergi/Istirahat)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Pergi/Istirahat',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Lingkungan)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Lingkungan',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).then((value) {
                if (value != null) {
                  print(value);
                }
              });
            },
            child: Image.asset(
              'assets/icon.pause.png',
              height: 25,
              width: 25,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: AppColors.blueOne,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Blocked',
                              style: TextStyle(
                                color: AppColors.greyThree,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Material Availability)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Material Availability',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Equiment Failure)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Equipment Failure',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Setup Adjustments)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Setup and Adjustments',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Reduced Speed)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Reduced Speed',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Process Defect)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Process Defect',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Reduced Yield)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Reduced Yield',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyThree,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Fully Productive Time)";
                                  _submitState();
                                },
                                child: const Text(
                                  'Fully Productive Time',
                                  style: TextStyle(
                                    color: AppColors.blueOne,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).then((value) {
                if (value != null) {
                  print(value);
                }
              });
            },
            child: Image.asset(
              'assets/icon.block.png',
              height: 25,
              width: 25,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              final id = widget.entry.id;
              idController.text = id;
              stateController.text = "End";
              _submitState();
            },
            child: Image.asset(
              'assets/icon.end.png',
              height: 25,
              width: 25,
            ),
          ),
        ],
      ),
    );
  }
}
