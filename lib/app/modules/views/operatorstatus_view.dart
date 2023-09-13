import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/machine_controller.dart';
import '../controllers/machinestate_controller.dart';
import '../controllers/response_model.dart';
import 'home_view.dart';

void main() {
  runApp(MaterialApp(
    home: OperatorStatusView(),
  ));
}

class OperatorStatusView extends StatefulWidget {
  const OperatorStatusView({Key? key}) : super(key: key);
  @override
  State<OperatorStatusView> createState() => _OperatorStatusViewState();
}

class _OperatorStatusViewState extends State<OperatorStatusView> {
  List<MyData> _data = [];
  int page = 1;
  int pageSize = 10;

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
      final response = await MachineController.postFormData(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Status Mesin",
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
                  CardTable(data: _data),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
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
        DataCell(Text(
          entry.id,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )),
        DataCell(AksiCellWidget(
          parentContext: parentContext,
          entry: entry,
        )),
        DataCell(Text(
          entry.mesin,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )),
        DataCell(Text(
          entry.operator,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )),
        DataCell(Text(
          entry.status,
          textAlign: TextAlign.left,
          style: TextStyle(
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
}

class CardTable extends StatelessWidget {
  final List<MyData> data;

  CardTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: PaginatedDataTable(
              header: Text(
                'Status Mesin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              columns: [
                DataColumn(
                  label: Flexible(
                    child: Text(
                      'ID',
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
              source: MyDataTableSource(data, context),
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

  AksiCellWidget({required this.parentContext, required this.entry});

  @override
  State<AksiCellWidget> createState() => _AksiCellWidgetState();
}

class _AksiCellWidgetState extends State<AksiCellWidget> {
  late DateTime currentTime;
  final stateController = TextEditingController();
  final idController = TextEditingController();

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
  }

  Future<void> _submitState() async {
    final int id = int.parse(idController.text);
    final String state = stateController.text;

    try {
      await fetchCurrentTime();

      ResponseModel response = await MachineStateController.postFormData(
        id: id,
        state: state,
        timestate: currentTime.toString(),
      );

      if (response.status == 1) {
        if (state == "Start") {
          Get.snackbar('nama mesin', 'started');
        } else if (state == "Pause (Naik WIP)") {
          Get.snackbar('nama mesin', 'paused');
        } else if (state == "Pause (Naik Bobin)") {
          Get.snackbar('nama mesin', 'paused');
        } else if (state == "Pause (Setup Mesin)") {
          Get.snackbar('nama mesin', 'paused');
        } else if (state == "Pause (Pergi/Istirahat)") {
          Get.snackbar('nama mesin', 'paused');
        } else if (state == "Pause (Lingkungan)") {
          Get.snackbar('nama mesin', 'paused');
        } else if (state == "Block (Material Availability)") {
          Get.snackbar('nama mesin', 'blocked');
        } else if (state == "Block (Equiment Failure)") {
          Get.snackbar('nama mesin', 'blocked');
        } else if (state == "Block (Setup Adjustments)") {
          Get.snackbar('nama mesin', 'blocked');
        } else if (state == "Block (Reduced Speed)") {
          Get.snackbar('nama mesin', 'blocked');
        } else if (state == "Block (Process Defect)") {
          Get.snackbar('nama mesin', 'blocked');
        } else if (state == "Block (Reduced Yield)") {
          Get.snackbar('nama mesin', 'blocked');
        } else if (state == "Block (Fully Productive Time)") {
          Get.snackbar('nama mesin', 'blocked');
        } else if (state == "End") {
          Get.snackbar('nama mesin', 'ended');
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OperatorStatusView()),
        );
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
          SizedBox(width: 10, height: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Color(0xFF084D88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Pause',
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Naik WIP)";
                                  _submitState();
                                },
                                child: Text(
                                  'Naik WIP',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Setup Mesin)";
                                  _submitState();
                                },
                                child: Text(
                                  'Set Up Mesin',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Naik Bobin)";
                                  _submitState();
                                },
                                child: Text(
                                  'Naik Bobin',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Pause (Pergi/Istirahat)";
                                  _submitState();
                                },
                                child: Text(
                                  'Pergi/Istirahat',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Pause (Lingkungan)";
                                  _submitState();
                                },
                                child: Text(
                                  'Lingkungan',
                                  style: TextStyle(
                                    color: Colors.blue[900],
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
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Color(0xFF084D88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Blocked',
                              style: TextStyle(
                                color: Color(0xFFD9D9D9),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Material Availability)";
                                  _submitState();
                                },
                                child: Text(
                                  'Material Availability',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Equiment Failure)";
                                  _submitState();
                                },
                                child: Text(
                                  'Equipment Failure',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Setup Adjustments)";
                                  _submitState();
                                },
                                child: Text(
                                  'Setup and Adjustments',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Reduced Speed)";
                                  _submitState();
                                },
                                child: Text(
                                  'Reduced Speed',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text = "Block (Process Defect)";
                                  _submitState();
                                },
                                child: Text(
                                  'Process Defect',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Reduced Yield)";
                                  _submitState();
                                },
                                child: Text(
                                  'Reduced Yield',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFD9D9D9),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final id = widget.entry.id;
                                  idController.text = id;
                                  stateController.text =
                                      "Block (Fully Productive Time)";
                                  _submitState();
                                },
                                child: Text(
                                  'Fully Productive Time',
                                  style: TextStyle(
                                    color: Colors.blue[900],
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
          SizedBox(width: 10),
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
