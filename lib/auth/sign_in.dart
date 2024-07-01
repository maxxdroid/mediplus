import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/auth/auth.dart';
import 'package:mediplus/auth/sign_up.dart';
import 'package:mediplus/widgets/loading_alert.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _eamilController = TextEditingController();
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: height * .15),
              const Center(
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              Center(
                child: SizedBox(
                  height: height * 0.2,
                  child: Image.asset("assets/images/icon2.png"),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Medi",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                  Text(
                    "+",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "  Email",
                        labelStyle: TextStyle(fontSize: 13),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail, color: Colors.blue),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                      ),
                      controller: _eamilController,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "  Password",
                        labelStyle: TextStyle(fontSize: 13),
                        border: InputBorder.none,
                        prefixIcon:
                            Icon(Icons.lock_open_rounded, color: Colors.blue),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                      ),
                      controller: _passwordController,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10),
                child: SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Don't have an account? "),
                        GestureDetector(
                            onTap: () {
                              Get.off(const SignUp(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(seconds: 1));
                            },
                            child: const Text(
                              "Sign up toaday!",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return const LoadingAlert(
                            message: 'Logging in please wait...',
                          );
                        });
                    AuthMethods().signIn(_eamilController.text, _passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: SizedBox(
                    width: width,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
