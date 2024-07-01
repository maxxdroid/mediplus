import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/auth/sign_up.dart';
import 'package:mediplus/screens/tabs/page_tabs.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                height: height * 0.6,
                child: Image.asset("assets/images/doctor1.png"),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "This is Medi",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "+",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                ),
              ],
            ),
            const Text(
              "Your Caring Partner!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "We won't let you",
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              "forget the intervals!",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(const SignUp(), transition: Transition.cupertino, duration: const Duration(seconds: 1));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                child: SizedBox(
                  width: width * 0.5,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Get  Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
