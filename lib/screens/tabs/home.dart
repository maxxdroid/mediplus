import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:mediplus/screens/details_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Fri, 21st June"),
            const Text(
              "Today's Plan",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("08:00 am"),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                Get.to(const DetailsPage(),transition: Transition.cupertino, duration: const Duration(seconds: 1));
              },
              child: Card(
                elevation: 0,
                color: Colors.lightBlue[50],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/pill1.png", width: 100, height: 50,),
                      const Column(
                        children: [
                          Text("Vitamin C pills", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("1 pill per Day")
                        ],
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text("12:00 pm"),
            ),
            Card(
              elevation: 0,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/pill2.png", width: 100, height: 70, fit: BoxFit.fitHeight,),
                    const Column(
                      children: [
                        Text("Vitamin D", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("2 pills per Week")
                      ],
                    ),
                    const Icon(Icons.navigate_next)
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/pill3.png", width: 100, height: 70, fit: BoxFit.fitHeight,),
                    const Column(
                      children: [
                        Text("Omega 3 pills", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("1 pill per Day")
                      ],
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
            ),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text("7:00 pm"),
            ),
            Card(
              elevation: 0,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/pill3.png", width: 100, height: 70, fit: BoxFit.fitHeight,),
                    const Column(
                      children: [
                        Text("Omega 3 pills", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("1 pill per Day")
                      ],
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/pill3.png", width: 100, height: 70, fit: BoxFit.fitHeight,),
                    const Column(
                      children: [
                        Text("Omega 3 pills", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("1 pill per Day")
                      ],
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Colors.lightBlue[50],
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/pill3.png", width: 100, height: 70, fit: BoxFit.fitHeight,),
                    const Column(
                      children: [
                        Text("Omega 3 pills", style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("1 pill per Day")
                      ],
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
