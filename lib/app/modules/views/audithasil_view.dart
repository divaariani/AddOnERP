import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_view.dart';
import 'audit_view.dart';
import '../controllers/audit_controller.dart';
import '../utils/app_colors.dart';

class AuditHasilView extends StatefulWidget {
  const AuditHasilView({Key? key}) : super(key: key);
  
  @override
  State<AuditHasilView> createState() => _AuditHasilViewState();
}

class _AuditHasilViewState extends State<AuditHasilView> {
  void handleRefresh(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuditHasilView()),
    );
  }

  @override
  void initState() {
    super.initState();
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
            const SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
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
                                text: "Auditor",
                                isActive: false,
                                targetPage: AuditView(),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: CustomButton(
                                text: "Stock",
                                isActive: true,
                                targetPage: AuditHasilView(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CardTable(),
                    SizedBox(height: 30),
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
                  "Audit Stock",
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

class CustomButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final Widget targetPage;

  const CustomButton({Key? key, required this.text, required this.isActive, required this.targetPage}) : super(key: key);

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
          pageBuilder: (context, animation, secondaryAnimation) => widget.targetPage,
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
      onTap: _navigateToTargetPage,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isActive
                ? [
                    AppColors.white,
                    AppColors.blueOne
                  ]
                : [
                    AppColors.white,
                    AppColors.blueThree
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: widget.isActive
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.isActive
                ? AppColors.white
                : AppColors.blueOne,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class MyData {
  final int? id;
  final String? lokasi;
  final String? lotbarang;
  final String? namabarang;
  final int? qty;
  final String? state;
  final String aksi;

  MyData({
    required this.id,
    required this.lokasi,
    required this.lotbarang,
    required this.namabarang,
    required this.qty,
    required this.state,
    required this.aksi
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
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              entry.lokasi ?? "", 
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
              entry.namabarang ?? "", 
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
              entry.lotbarang ?? "", 
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
              entry.qty?.toString() ?? "", 
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
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: entry.state == 'confirm' ? Colors.green : Colors.orange,
              ),
            ),
          ),
        ),
        DataCell(
          AksiCellWidget(
            entry: entry,
            onDelete: onDelete,
            data: data, 
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
  const CardTable({Key? key}) : super(key: key);

  @override
  _CardTableState createState() => _CardTableState();
}

class _CardTableState extends State<CardTable> {
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<MyData> _data = [];
  bool _isLoading = false;

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

    final response = await AuditController.viewData(id: 1, lokasi: '', lotBarang: '', namabarang: '', qty: 1, state: '');

    final List<dynamic> nameDataList = response.data;
    print('API Response: $nameDataList');

    final List<MyData> myDataList = nameDataList.map((data) {
      int id = int.tryParse(data['id'].toString()) ?? 0;
      String lokasi = data['lokasi'] ?? ""; 
      String lotbarang = data['lot_barang'] ?? ""; 
      String namabarang = data['namabarang'] ?? ""; 
      int qty = int.tryParse(data['qty'].toString()) ?? 0;
      String state = data['state'] ?? ""; 

      return MyData(
        id: id,
        lokasi: lokasi,
        lotbarang: lotbarang,
        namabarang: namabarang,
        qty: qty,
        state: state,
        aksi: ''
      );
    }).toList();

    setState(() {
      _data = myDataList.where((data) {
        return (data.lokasi?.toLowerCase() ?? "").contains(_searchResult.toLowerCase()) ||
              (data.namabarang?.toLowerCase() ?? "").contains(_searchResult.toLowerCase()) ||
              (data.lotbarang?.toLowerCase() ?? "").contains(_searchResult.toLowerCase()) ||
              (data.state?.toLowerCase() ?? "").contains(_searchResult.toLowerCase());
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Row(
            children: [
              Expanded(
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
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : _data.isEmpty
                        ? const EmptyData()
                        : PaginatedDataTable(
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Lokasi',
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
                                  'Lot Barang',
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
                              DataColumn(
                                label: Text(
                                  'Aksi',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                            source: MyDataTableSource(_data, onDelete: (int id) {
                            AuditController.deleteData(id);
                          }),
                            rowsPerPage: 10,
                          ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AksiCellWidget extends StatefulWidget {
  final MyData entry;
  final Function(int) onDelete;
  final List<MyData> data;

  const AksiCellWidget({Key? key, required this.entry, required this.onDelete, required this.data}): super(key: key);

  @override
  State<AksiCellWidget> createState() => _AksiCellWidgetState();
}

class _AksiCellWidgetState extends State<AksiCellWidget> {
  final idController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitAction() async {
    try {
      widget.onDelete(widget.entry.id!);

      setState(() {
        widget.data.removeWhere((element) => element.id == widget.entry.id);
      });

      final cardTableState = context.findAncestorStateOfType<_CardTableState>();
      cardTableState?.setState(() {});

      Get.snackbar(
        'Sukses',
        'Kode Barang ${widget.entry.lotbarang} berhasil dihapus.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AuditHasilView()));

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
          color: Colors.red,
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
                    child: Column(
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
                            color: AppColors.blueOne,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.greyThree,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Batal',
                                style: TextStyle(
                                  color: AppColors.blueOne,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                _submitAction();
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
                                  color: AppColors.white,
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

class EmptyData extends StatelessWidget {
  const EmptyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        width: 1 * MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icon.nodata.png',
                  width: 30,
                  height: 30,
                  color: AppColors.blueOne,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Tidak ada barang',
                    style: GoogleFonts.poppins(
                      color: AppColors.blueOne,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
