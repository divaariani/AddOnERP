import 'package:flutter/material.dart';
import '../controllers/machine_controller.dart';
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

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
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
  final String aksi;
  final String mesin;
  final String operator;
  final String status;

  MyData({
    required this.aksi,
    required this.mesin,
    required this.operator,
    required this.status,
  });
}

class AksiCellWidget extends StatelessWidget {
  final BuildContext parentContext;
  final MyData entry;
  AksiCellWidget({required this.parentContext, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // on tap logic here
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
                                  // onpressed logic
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
              // on tap logic here
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
