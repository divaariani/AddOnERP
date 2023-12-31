import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.blue.shade200,
              ],
              stops: [0.8, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset("assets/logo.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Created by:   ",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.blue[900],
                      ),
                    ),
                    Container(
                      width: 0.25 * MediaQuery.of(context).size.width,
                      height: 0.25 * MediaQuery.of(context).size.height,
                      child: Image.asset("assets/logocopyright.png"),
                    ),
                    SizedBox(width: 10),
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