import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/auth/auth.dart';
import 'package:mediplus/auth/sign_in.dart';
import 'package:mediplus/widgets/loading_alert.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _eamilController = TextEditingController();
  bool obscured = true;
  bool confirmObscured = true;

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
              SizedBox(height: height * .1),
              const Center(
                child: Text(
                  "Sign Up",
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
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
                        labelText: "  Full Name",
                        labelStyle: TextStyle(fontSize: 13),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                      ),
                      controller: _nameController,
                    ),
                  ),
                ),
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
                      obscureText: obscured,
                      decoration: InputDecoration(
                        labelText: "  Password",
                        labelStyle: const TextStyle(fontSize: 13),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (obscured) {
                                  obscured = false;
                                } else {
                                  obscured = true;
                                }
                              });
                            },
                            icon: obscured
                                ? const Icon(Icons.visibility,
                                    color: Colors.grey)
                                : const Icon(Icons.visibility_off,
                                    color: Colors.grey)),
                        prefixIcon: const Icon(Icons.lock_open_rounded,
                            color: Colors.blue),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                      ),
                      controller: _passwordController,
                    ),
                  ),
                ),
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
                      obscureText: confirmObscured,
                      decoration: InputDecoration(
                        labelText: "  Confirm Password",
                        labelStyle: const TextStyle(fontSize: 13),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.lock_outline_rounded,
                            color: Colors.blue),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (confirmObscured) {
                                  confirmObscured = false;
                                } else {
                                  confirmObscured = true;
                                }
                              });
                            },
                            icon: confirmObscured
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  )
                                : const Icon(Icons.visibility_off,
                                    color: Colors.grey)),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                      ),
                      controller: _confirmPasswordController,
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
                        const Text("Already have an account? "),
                        GestureDetector(
                            onTap: () {
                              Get.off(const SignIn(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(seconds: 1));
                            },
                            child: const Text(
                              "Sign in!",
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
                            message: 'Creating your account...',
                          );
                        });
                    AuthMethods().signUp(
                        _eamilController.text.toString(),
                        _passwordController.text.trim(),
                        _nameController.text.toString());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: SizedBox(
                    width: width,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Sign Up",
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
