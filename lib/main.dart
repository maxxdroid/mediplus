import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediplus/screens/Page_tabs.dart';
// import 'package:mediplus/screens/lading_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blueAccent, // navigation bar color
    statusBarColor: Colors.blueAccent, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PageTabs(),
    );
  }
}
