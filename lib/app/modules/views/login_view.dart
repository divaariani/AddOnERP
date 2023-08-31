import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'register_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = Get.put(LoginController());
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
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
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: 0.164 * MediaQuery.of(context).size.height,
                  width: 0.232 * MediaQuery.of(context).size.height,
                ),
              ),
              Spacer(),
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
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Login to your account",
                          style: TextStyle(
                            color: Color(0xFF084D88),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
                      TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          hintText: "Username or Email",
                        ),
                      ),
                      SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                      TextField(
                        controller: controller.passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
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
                      SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
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
                                        'LOGIN',
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
                      SizedBox(height: 0.1 * MediaQuery.of(context).size.height),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => RegisterView());
                                  },
                                text: "Register",
                                style: TextStyle(
                                  color: Color(0xFF084D88),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 0.1 * MediaQuery.of(context).size.height),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}