import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/cart.dart';
import 'package:mediplus/screens/details_page.dart';
import 'package:mediplus/screens/order_medication.dart';
import 'package:mediplus/screens/tabs/medications.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  List<String> _medicationTypes = [];
  bool inCart = false;
  List<Medication> cart = [];
  int cartItems = 0;
  bool isVisible = true;
  LocalUser? user =
      LocalUser(name: "", role: "", imageUrl: "", userID: "", email: "");

  @override
  void initState() {
    super.initState();
    _getUser();
    WidgetsBinding.instance.addObserver(this);
    _loadcart();
    fetchMedicationTypes();
  }

  Future<void> _getUser() async {
    user = await Sharedprefhelper().getUser();
    print('Error fetching user info: ${user!.email}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && isVisible) {
      _loadcart();
    }
  }

  Future<void> _loadcart() async {
    cart = await Sharedprefhelper().getCurrentMedicationCart();
    if (mounted) {
      setState(() {
        cartItems = cart.length;
      });
    }
  }

  Future<void> fetchMedicationTypes() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("medication").get();
    List<String> types =
        snapshot.docs.map((doc) => doc['type'] as String).toSet().toList();
    setState(() {
      _medicationTypes = types;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> medications(
      BuildContext context, String type) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("medication")
            .where("type", isEqualTo: type)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Medication medication =
                      Medication.fromJson(snapshot.data!.docs[index].data());
                  return medicationcard(medication, context);
                });
          }
          return const SizedBox();
        });
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> popularMedications(
      BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("medication")
            .limit(10)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Medication medication =
                      Medication.fromJson(snapshot.data!.docs[index].data());
                  return medicationcard(medication, context);
                });
          }
          return const SizedBox();
        });
  }

  Widget actionsHub() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      children: [
        InkWell(
          onTap: () {
            Get.to(Medications(userID: user!.userID));
          },
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/medicines.jpg")),
              Card(
                color: Colors.lightBlue[50],
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Manage "),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(const OrderMedication());
          },
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/buy.jpg")),
              Card(
                color: Colors.lightBlue[50],
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Order"),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/report.jpeg")),
              Card(
                color: Colors.lightBlue[50],
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Report"),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(const OrderMedication());
          },
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/buy.jpg")),
              Card(
                color: Colors.lightBlue[50],
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Add Medication"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Medi",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent[700]),
                        ),
                        const Text(
                          "+",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(() => const Cart());
                          },
                          icon: const Icon(
                            Icons.medical_services,
                            color: Colors.blue,
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 5.0, bottom: 5),
                            child: Text("$cartItems"),
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue[50]),
              height: height * 0.2,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            width: width * 0.4,
                            child: const Text(
                              "Your Trusted Partner in Health",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: width * .4,
                          child: const Text(
                              "Caring for You, Every Step of the Way",
                              style: TextStyle()),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.2,
                    width: width * 0.4,
                    child: Image.asset(
                        fit: BoxFit.fitWidth, "assets/images/doctor.png"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * .3,
              child: actionsHub(),
            ),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 5.0, top: 10),
                child: Text(
                  "Popular Medications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: height * .25,
                child: popularMedications(context),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget medicationcard(Medication medication, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Get.to(DetailsPage(medication: medication));
      },
      child: SizedBox(
        height: height * .22,
        width: width * .4,
        child: Card(
          color: Colors.lightBlue[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  medication.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  medication.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Dosage: "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageWrapper extends StatefulWidget {
  @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      children: [
        Home(key: PageStorageKey('Home')),
        // Add other pages here
      ],
    );
  }
}
