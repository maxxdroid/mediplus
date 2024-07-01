import 'package:flutter/material.dart';
import 'package:mediplus/screens/tabs/add_medication/add_medication.dart';
import 'package:mediplus/screens/tabs/history.dart';
import 'package:mediplus/screens/tabs/home.dart';
import 'package:mediplus/screens/tabs/medications.dart';
import 'package:mediplus/screens/tabs/profile.dart';

class PageTabs extends StatefulWidget {
  const PageTabs({super.key});

  @override
  State<PageTabs> createState() => _PageTabs();
}

class _PageTabs extends State<PageTabs> {
  int pageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    setState(() {});
    pageController = PageController(initialPage: pageIndex);

    pageController.addListener(() {
      setState(() {
        pageIndex = pageController.page!.round();
      });
    });
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
          children: const [Home(),History(), AddMedication(), Medications(), Profile()],
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(fontSize: 10, color: Colors.lightBlueAccent),
            showUnselectedLabels: false,
            selectedIconTheme: const IconThemeData(size: 30, color: Colors.lightBlueAccent),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.house), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline_outlined), label: 'Add Medication'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.medical_information), label: 'Medications'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
    );
  }
}
