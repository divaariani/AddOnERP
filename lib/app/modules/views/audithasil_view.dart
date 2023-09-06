import 'package:flutter/material.dart';
import 'home_view.dart';
import 'audit_view.dart';

void main() {
  runApp(MaterialApp(
    home: AuditHasilView(),
  ));
}

class AuditHasilView extends StatefulWidget {
  const AuditHasilView({Key? key}) : super(key: key);
  @override
  State<AuditHasilView> createState() => _AuditHasilViewState();
}

class _AuditHasilViewState extends State<AuditHasilView> {
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
                            "Audit Stock",
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(left: 23),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Barang Scan",
                              isActive: false,
                              targetPage: AuditView(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: CustomButton(
                              text: "Hasil Scan",
                              isActive: true,
                              targetPage: AuditHasilView(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: " Search...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(Icons.search),
                        suffixIconConstraints: BoxConstraints(minWidth: 40),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  CardTable(),
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

class CustomButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final Widget targetPage;

  CustomButton(
      {required this.text, required this.isActive, required this.targetPage});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isCurrentPage = false;

  @override
  void initState() {
    super.initState();
    isCurrentPage = widget.targetPage.runtimeType == AuditHasilView;
  }

  void _navigateToTargetPage() {
    if (!isCurrentPage) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              widget.targetPage,
          transitionDuration: Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToTargetPage,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isActive
                ? [
                    const Color.fromRGBO(255, 255, 255, 1),
                    Color.fromARGB(56, 0, 151, 251)
                  ]
                : [
                    Color.fromARGB(255, 255, 255, 255),
                    const Color.fromRGBO(96, 187, 231, 1)
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: widget.isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]
              : [],
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.isActive
                ? Colors.white
                : const Color.fromRGBO(8, 77, 136, 1),
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class MyData {
  final String ruangan;
  final String lotbarang;
  final int kuantitas;
  final String state;

  MyData({
    required this.ruangan,
    required this.lotbarang,
    required this.kuantitas,
    required this.state,
  });
}

class MyDataTableSource extends DataTableSource {
  final List<MyData> data;
  MyDataTableSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    final entry = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Center(
            child: Text(
          entry.ruangan,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ))),
        DataCell(Center(
            child: Text(
          entry.lotbarang,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ))),
        DataCell(Center(
            child: Text(
          entry.kuantitas.toString(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ))),
        DataCell(Center(
            child: Text(
          entry.state,
          style: TextStyle(
            fontSize: 12,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ))),
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
  final List<MyData> data = [
    MyData(ruangan: 'IT', lotbarang: 'K0D2512', kuantitas: 1, state: 'Confirm'),
    MyData(ruangan: 'IT', lotbarang: 'K0A0909', kuantitas: 1, state: 'Confirm'),
    MyData(ruangan: 'HRD', lotbarang: 'K0H2512', kuantitas: 1, state: 'Confirm'),
    MyData(ruangan: 'HRD', lotbarang: 'K0H2512', kuantitas: 1, state: 'Confirm'),
    MyData(ruangan: 'HRD', lotbarang: 'K0H2512', kuantitas: 1, state: 'Confirm'),
    MyData(ruangan: 'HRD', lotbarang: 'K0H2512', kuantitas: 1, state: 'Confirm'),
    MyData(ruangan: 'IT', lotbarang: 'K0D2512', kuantitas: 1, state: 'Confirm'),
    MyData(ruangan: 'IT', lotbarang: 'K0A0909', kuantitas: 1, state: 'Confirm'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 26),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PaginatedDataTable(
              header: Text(
                'Audit Stock',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              columns: [
                DataColumn(
                    label: Text(
                  'Ruangan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Lot Barang',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Kuantitas',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
                DataColumn(
                    label: Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
              ],
              source: MyDataTableSource(data),
              rowsPerPage: 10,
            ),
          ),
        ),
      ],
    );
  }
}