import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'login_view.dart';
import '../controllers/login_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  LoginController controller = Get.put(LoginController());
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(1.99, -1.14),
            end: Alignment(-1.99, 1.14),
            colors: [Color(0xFF0171BB), Color(0xFFFAFAFA)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset("assets/logo.png"),
            SizedBox(height: 60),
            Card(
              margin: EdgeInsets.zero,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 30,
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Create a new account",
                        style: TextStyle(
                          color: Color(0xFF084D88),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      // controller: controller.emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        hintText: "Username",
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      // controller: controller.emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      // controller: controller.passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          hintText: "Password",
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      // controller: controller.passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      return InkWell(
                        onTap: () async {
                          controller.loginApi();
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-0.71, 0.71),
                              end: Alignment(0.71, -0.71),
                              colors: [
                                Color(0xFF084D88),
                                Color(0xFF0171BB),
                                Color(0xFF0171BB)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            height: 45,
                            child: Center(
                              child: controller.loading.value
                                  ? CircularProgressIndicator()
                                  : Text(
                                      'REGISTER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 50),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => LoginView());
                                },
                              text: "Login",
                              style: TextStyle(
                                color: Color(0xFF084D88),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}