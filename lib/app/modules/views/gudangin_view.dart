import 'package:addon/app/modules/controllers/gudangdelete_controller.dart';
import 'package:addon/app/modules/views/scangudang_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import '../controllers/gudanginview_controller.dart';
import '../utils/sessionmanager.dart';
import 'gudanghasil_view.dart';
import 'package:flutter/src/widgets/basic.dart' as flutter;
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GudangInView(),
    );
  }
}

class GudangInView extends StatefulWidget {
  const GudangInView({Key? key}) : super(key: key);
  @override
  State<GudangInView> createState() => _GudangInViewState();
}

class _GudangInViewState extends State<GudangInView> {
  int page = 1;
  int pageSize = 10;
  String searchText = "";

  final SessionManager sessionManager = SessionManager();
  String userIdLogin = "";

  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    print('Building GudangHasilView');

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: flutter.Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: 360,
              height: 800,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: flutter.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: flutter.Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: CustomButton(
                                text: "Gudang In",
                                isActive: true,
                                targetPage: GudangInView(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: CustomButton(
                                text: "Gudang Out",
                                isActive: false,
                                targetPage: GudangHasilView(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    CardTable(searchText),
                    SizedBox(height: 30),
                    flutter.Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScanGudangView()),
                            );
                          },
                          icon: Icon(Icons.qr_code_scanner),
                          label: Text('Scan Barang'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(8, 77, 136, 136),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            minimumSize: Size(160, 48),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Color(0xFF2A77AC),
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  },
                  child: Image.asset(
                    'assets/icon.back.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                title: Text(
                  "Warehouse",
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
    isCurrentPage = widget.targetPage.runtimeType == GudangInView;
  }

  void _navigateToTargetPage(BuildContext context) {
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
      onTap: () {
        _navigateToTargetPage(context);
      },
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
  final String? checked;
  final int? id;
  final String? tgl_kp;
  final String? lotnumber;
  final String? namabarang;
  final int? qty;
  final String? uom;

  MyData({
    required this.checked,
    required this.id,
    required this.tgl_kp,
    required this.lotnumber,
    required this.namabarang,
    required this.qty,
    required this.uom,
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
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.checked ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.id.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.tgl_kp ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.lotnumber ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.namabarang ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.qty.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.uom ?? "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
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

class CardTable extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  final String searchText;
  CardTable(this.searchText);

  @override
  _CardTableState createState() => _CardTableState(searchText);
}

class _CardTableState extends State<CardTable> {
  TextEditingController controller = TextEditingController();
  List<MyData> _data = [];
  bool _isLoading = false;
  String _searchResult = '';
  final String searchText;
  _CardTableState(this.searchText);

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

  Future<void> fetchDataFromAPI() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final DateTime tgl_kp = DateTime.now();
      final response = await GudangInViewController.postFormData(
        checked: '',
        id: 1,
        tgl_kp: tgl_kp,
        lotnumber: '',
        namabarang: '',
        qty: 1,
        uom: '',
      );

      final List<dynamic> nameDataList = response.data;
      print('API Response: $nameDataList');

      final List<MyData> myDataList = nameDataList.map((data) {
        String checked = data['checked'] ?? "";
        int id = int.tryParse(data['id'].toString()) ?? 0;
        String tgl_kp = data['tgl_kp'] ?? "";
        String lotnumber = data['lotnumber'] ?? "";
        String namabarang = data['namabarang'] ?? "";
        int qty = int.tryParse(data['qty'].toString()) ?? 0;
        String uom = data['uom'] ?? "";

        return MyData(
          checked: checked,
          id: id,
          tgl_kp: tgl_kp,
          lotnumber: lotnumber,
          namabarang: namabarang,
          qty: qty,
          uom: uom,
        );
        //print('$MyData');
      }).toList();

      setState(() {
        _data = myDataList.where((data) {
          return (data.tgl_kp?.toLowerCase() ?? "")
                  .contains(_searchResult.toLowerCase()) ||
              (data.namabarang?.toLowerCase() ?? "")
                  .contains(_searchResult.toLowerCase()) ||
              (data.lotnumber?.toLowerCase() ?? "")
                  .contains(_searchResult.toLowerCase()) ||
              (data.uom?.toLowerCase() ?? "")
                  .contains(_searchResult.toLowerCase());
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
  Widget build(BuildContext context) {
    return flutter.Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: flutter.Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
            ],
          ),
        ),
        const SizedBox(height: 10),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 26),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: flutter.Column(children: [
              _isLoading
                  ? CircularProgressIndicator()
                  : _data.isEmpty
                      ? EmptyData()
                      : PaginatedDataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Checked',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Id',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Tanggal Kp',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Lot Number',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Nama Barang',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                             DataColumn(
                              label: Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                             DataColumn(
                              label: Text(
                                'Uom',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                          source: MyDataTableSource(_data),
                          rowsPerPage: 10,
                        ),
            ]),
          ),
        ),
      ],
    );
  }
}

class EmptyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: 1 * MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: flutter.Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.nodata.png',
              width: 30,
              height: 30,
              color: Colors.blue[900],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Tidak ada hasil scan barang',
                style: GoogleFonts.poppins(
                  color: Colors.blue[900],
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataProvider extends ChangeNotifier {
  List<MyData> _data = [];

  List<MyData> get data => _data;

  void setData(List<MyData> newData) {
    _data = newData;
    notifyListeners();
  }

  void deleteData(int id) {
    _data.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 0, 0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: flutter.Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'assets/icon.warning.png',
                            width: 70,
                            height: 70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Apakah yakin akan dihapus?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF084D88),
                          ),
                        ),
                        const SizedBox(height: 10),
                        flutter.Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffD1D3D9),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  color: Color(0xFF084D88),
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Center(
            child: Image.asset(
              'assets/icon.delete.png',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

