import 'package:addon/app/modules/controllers/gudangdelete_controller.dart';
import 'package:addon/app/modules/views/gudangin_view.dart';
import 'package:addon/app/modules/views/scangudang_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'home_view.dart';
import '../controllers/gudangview_controller.dart';
import '../utils/sessionmanager.dart';
import 'package:flutter/src/widgets/basic.dart' as flutter;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:excel/excel.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GudangOutView(),
    );
  }
}

class GudangOutView extends StatefulWidget {
  const GudangOutView({Key? key}) : super(key: key);
  @override
  State<GudangOutView> createState() => _GudangOutViewState();
}

class _GudangOutViewState extends State<GudangOutView> {
  final SessionManager sessionManager = SessionManager();
  int page = 1;
  int pageSize = 10;
  String searchText = "";
  String userIdLogin = "";

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    //print('Building GudangHasilView');

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
        body: flutter.Stack(
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
                    const SizedBox(height: 70),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 23),
                        child: flutter.Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: CustomButton(
                                text: "Gudang In",
                                isActive: false,
                                targetPage: const GudangInView(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: CustomButton(
                                text: "Gudang Out",
                                isActive: true,
                                targetPage: const GudangOutView(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CardTable(searchText),
                    const SizedBox(height: 30),
                    flutter.Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScanGudangView()),
                            );
                          },
                          icon: const Icon(Icons.qr_code_scanner),
                          label: const Text('Scan Mobil'),
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
                    const SizedBox(
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
                backgroundColor: const Color(0xFF2A77AC),
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
    isCurrentPage = widget.targetPage.runtimeType == GudangOutView;
  }

  void _navigateToTargetPage(BuildContext context) {
    if (!isCurrentPage) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              widget.targetPage,
          transitionDuration: const Duration(milliseconds: 150),
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
                   const Color.fromARGB(56, 0, 151, 251)
                  ]
                : [
                   const Color.fromARGB(255, 255, 255, 255),
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
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
  final int? id;
  final int? userid;
  final String? barcode_mobil;
  final String? lotnumber;
  final String? name;
  final int? quantity;
  final String? state;
  final String aksi;

  MyData({
    required this.id,
    required this.userid,
    required this.barcode_mobil,
    required this.lotnumber,
    required this.name,
    required this.quantity,
    required this.state,
    required this.aksi,
  });
}

class MyDataTableSource extends DataTableSource {
  final List<MyData> data;
  final Function(int) onDelete;

  MyDataTableSource(this.data, {required this.onDelete});

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
          AksiCellWidget(
            entry: entry,
            onDelete: onDelete,
            data: data,
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.barcode_mobil ?? "",
              style: const TextStyle(
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
              entry.name ?? "",
              style: const TextStyle(
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
              style: const TextStyle(
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
              entry.quantity.toString(),
              style: const TextStyle(
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
              entry.state ?? "",
              style: const TextStyle(
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
  List<MyData> _fetchedData = [];
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

      final response = await GudangViewController.postFormData(
        id: 1,
        userid: 1,
        barcode_mobil: '',
        lotnumber: '',
        name: '',
        quantity: 1,
        state: '',
      );

      final List<dynamic> nameDataList = response.data;
      //print('API Response: $nameDataList');

      final List<MyData> myDataList = nameDataList.map((data) {
        int id = int.tryParse(data['id'].toString()) ?? 0;
        int userid = int.tryParse(data['userid'].toString()) ?? 0;
        String barcode_mobil = data['barcode_mobil'] ?? "";
        String lotnumber = data['lotnumber'] ?? "";
        String name = data['name'] ?? "";
        int quantity = int.tryParse(data['quantity'].toString()) ?? 0;
        String state = data['state'] ?? "";

        return MyData(
          id: id,
          userid: userid,
          barcode_mobil: barcode_mobil,
          lotnumber: lotnumber,
          name: name,
          quantity: quantity,
          state: state,
          aksi: '',
        );
        //print('$MyData');
      }).toList();

      _fetchedData = myDataList;

      setState(() {
        _data = myDataList.where((data) {
          return (data.barcode_mobil?.toLowerCase() ?? "")
                  .contains(_searchResult.toLowerCase()) ||
              (data.name?.toLowerCase() ?? "")
                  .contains(_searchResult.toLowerCase()) ||
              (data.lotnumber?.toLowerCase() ?? "")
                  .contains(_searchResult.toLowerCase()) ||
              (data.quantity?.toString() ?? "")
                .contains(_searchResult.toLowerCase()) ||
              (data.state?.toLowerCase() ?? "")
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

  Future<void> createAndExportExcel(List<String> data) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      if (!status.isGranted) {
        return;
      }
    }

    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];

    sheet.appendRow(['Kode Mobil', 'Nama Barang', 'Kode Barang', 'Kuantitas', 'Status']);
    
    for (MyData data in _fetchedData) {
      sheet.appendRow([
        data.barcode_mobil.toString(),
        data.name.toString(),
        data.lotnumber,
        data.quantity,
        data.state,
      ]);
    }

    for (var cell in sheet.row(0)) {
      if (cell != null) {
        cell.cellStyle = CellStyle(
          bold: true,
        );
      }
    }

    final excelFile = File('${(await getTemporaryDirectory()).path}/GudangOut.xlsx');
    final excelData = excel.encode()!;

    await excelFile.writeAsBytes(excelData);

    if (excelFile.existsSync()) {
      Share.shareFiles(
        [excelFile.path],
        text: 'Exported Excel',
      );
    } else {
      print('File Excel not found.');
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
          margin: const EdgeInsets.symmetric(horizontal: 26),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: flutter.Column(children: [
              _isLoading
                  ? const CircularProgressIndicator()
                  : _data.isEmpty
                      ? EmptyData()
                      : PaginatedDataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Aksi',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Kode Mobil',
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
                                'Kode Barang',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Kuantitas',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                          source: MyDataTableSource(_data, onDelete: (int id) {
                            GudangDeleteController.deleteData(id);
                          }),
                          rowsPerPage: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            createAndExportExcel(_data.map((data) => data.toString()).toList());
                          },
                          child: Text('Export to Excel'),
                        )
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

class AksiCellWidget extends StatefulWidget {
  final MyData entry;
  final Function(int) onDelete;
  final List<MyData> data;

  AksiCellWidget(
      {required this.entry, required this.onDelete, required this.data});

  @override
  State<AksiCellWidget> createState() => _AksiCellWidgetState();
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

class _AksiCellWidgetState extends State<AksiCellWidget> {
  final idController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitState(BuildContext context) async {
    try {
      final myDataProvider =
          Provider.of<MyDataProvider>(context, listen: false);
      if (widget.entry.id != null) {
        myDataProvider.deleteData(
            widget.entry.id!); 
      }

      final _data = myDataProvider.data;

      setState(() {
        _data.removeWhere((element) => element.id == widget.entry.id);
      });

      Get.snackbar(
        'Sukses',
        'Kode Barang ${widget.entry.lotnumber} berhasil dihapus.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );

      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => GudangHasilView()));
    } catch (e) {
      Get.snackbar(
        'Kesalahan',
        'Terjadi kesalahan saat menghapus data: $e',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
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
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                _submitState(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Hapus',
                                style: TextStyle(
                                  color: Color(0xFFFAFAFA),
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
}
