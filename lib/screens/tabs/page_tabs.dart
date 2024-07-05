import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/tabs/add_medication/add.dart';
import 'package:mediplus/screens/tabs/home.dart';
import 'package:mediplus/screens/tabs/medications.dart';
import 'package:mediplus/screens/tabs/orders.dart';
import 'package:mediplus/screens/tabs/profile.dart';

class PageTabs extends StatefulWidget {
  LocalUser user;
  PageTabs({super.key, required this.user});

  @override
  State<PageTabs> createState() => _PageTabsState();
}

class _PageTabsState extends State<PageTabs> {
  String userID = "";
  int pageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndex);
    pageController.addListener(() {
      setState(() {
        pageIndex = pageController.page!.round();
      });
    });
    _getUserId();
  }

  Future<void> _getUserId() async {
    userID = (await Sharedprefhelper().getUserID())!;
    fetchUserInfo(userID!);
  }

  Future<void> fetchUserInfo(String id) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      if (userDoc.exists) {
        setState(() {
          // userInfo = userDoc.data() as Map<String, dynamic>?;
          print('User info fetched: $userDoc');
        });
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
            if (index == 0) {
              // Refresh the Home page state when it becomes visible
              // (Home).createState()._loadcart();
            }
          },
          children: [
            const Home(key: PageStorageKey('Home')),
            const Orders(),
            const AddForm(),
            Medications(
              userID: userID,
            ),
            Profile(user: widget.user,),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle:
              const TextStyle(fontSize: 10, color: Colors.lightBlueAccent),
          showUnselectedLabels: false,
          selectedIconTheme:
              const IconThemeData(size: 30, color: Colors.lightBlueAccent),
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: pageIndex,
          type: BottomNavigationBarType.fixed,
          onTap: ((index) {
            setState(() {
              pageIndex = index;
            });
            pageController.jumpToPage(index);
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_information_sharp), label: 'Orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_outlined),
                label: 'Add Medication'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medication), label: 'Medications'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
