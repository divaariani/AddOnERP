import 'package:flutter/material.dart';
import 'home_view.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';

void main() {
  runApp(MaterialApp(
    home: OperatorMonitorView(),
  ));
}

class OperatorMonitorView extends StatefulWidget {
  const OperatorMonitorView({Key? key}) : super(key: key);

  @override
  State<OperatorMonitorView> createState() => _OperatorMonitorViewState();
}

class _OperatorMonitorViewState extends State<OperatorMonitorView> {
  String selectedOption = 'All';

  void _onOptionSelected(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: 360,
            height: 800,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.99, -0.14),
                end: Alignment(-0.99, 0.14),
                colors: [Color(0xFF2A77AC), Color(0xFF5AB4E1)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
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
                            "Production Monitoring",
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Pilih Lokasi: ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 16),
                        Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8, bottom: 8, left: 24, right: 8),
                              child: PopupMenuButton<String>(
                                onSelected: _onOptionSelected,
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'All',
                                    child: ListTile(
                                      title: Text('All'),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'SKI',
                                    child: ListTile(
                                      title: Text('SKI'),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'SKC',
                                    child: ListTile(
                                      title: Text('SKC'),
                                    ),
                                  ),
                                ],
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      selectedOption,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF2A77AC)),
                                    ),
                                    SizedBox(width: 16),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MachineCard(
                                name: 'Drawing A',
                                location: 'SKI',
                                progress: 75),
                            MachineCard(
                                name: 'Drawing C',
                                location: 'SKI',
                                progress: 50),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MachineCard(
                                name: 'Drawing MC',
                                location: 'SKI',
                                progress: 25),
                            MachineCard(
                                name: 'Bunching A',
                                location: 'SKC',
                                progress: 90),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MachineCard(
                                name: 'Tubular 19',
                                location: 'SKC',
                                progress: 25),
                            MachineCard(
                                name: 'Extruder 100 A',
                                location: 'SKC',
                                progress: 90),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MachineCard extends StatelessWidget {
  final String name;
  final String location;
  final int progress;

  MachineCard(
      {required this.name, required this.location, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.45 * MediaQuery.of(context).size.width,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: location == 'SKI'
                            ? Colors.green
                            : location == 'SKC'
                                ? Colors.orange
                                : Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CustomPaint(
                        painter: SemiCircleProgressBar(progress: progress),
                        child: Center(
                          child: Text(
                            '$progress%',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            'MTR',
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            '500000',
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SemiCircleProgressBar extends CustomPainter {
  final int progress;

  SemiCircleProgressBar({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    final double startAngle = -0.5 * 3.14; // Start at the top (12 o'clock)
    final double progressAngle = (progress / 100) * 3.14; // Calculate progress angle

    canvas.drawArc(
      rect,
      startAngle,
      progressAngle,
      false,
      paint,
    );

    // Add "0" text at the start of the progress half circle (9 o'clock)
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '0',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    double textX = size.width / 4 - textPainter.width / 2; // Adjust X position for 9 o'clock
    double textY = size.height / 2 - textPainter.height / 2;
    textPainter.paint(canvas, Offset(textX, textY));

    // Add "MTR" text at the center
    textPainter.text = TextSpan(
      text: 'MTR',
      style: TextStyle(fontSize: 12, color: Colors.black),
    );

    textPainter.layout();
    textX = size.width / 2 - textPainter.width / 2;
    textY = size.height / 2 - textPainter.height / 2;
    textPainter.paint(canvas, Offset(textX, textY));

    // Add "500000" text at the end of the progress half circle (3 o'clock)
    textPainter.text = TextSpan(
      text: '500000',
      style: TextStyle(fontSize: 12, color: Colors.black),
    );

    textPainter.layout();
    textX = (3 * size.width) / 4 - textPainter.width / 2; // Adjust X position for 3 o'clock
    textY = size.height / 2 - textPainter.height / 2;
    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
