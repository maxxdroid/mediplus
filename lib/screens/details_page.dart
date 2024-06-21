import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {
                          Get.back();
                        }, icon: const Icon(Icons.arrow_back_ios_rounded)),
                        const Text("Edit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.5,
                    child: Image.asset(
                      "assets/images/pill1.png",
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Vitamin C pills", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Program"),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.lightBlue[50],
                    child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: const Text("1 pill everyday at 08:00pm")),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        // Get.to(const PageTabs(), transition: Transition.cupertino, duration: const Duration(seconds: 1));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.blueGrey[100]),
                      child: SizedBox(
                        width: width * 0.3,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        // Get.to(const PageTabs(), transition: Transition.cupertino, duration: const Duration(seconds: 1));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.blueAccent),
                      child: SizedBox(
                        width: width * 0.3,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
