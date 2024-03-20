import 'package:finalproject/otherreport.dart';
import 'package:finalproject/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/homepage.dart';
import 'package:finalproject/profile.dart';
import 'package:finalproject/login_register_page.dart';
import 'package:finalproject/report.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCkhKGeMHKeibpsQ40CvSs-_ND6e5CgcSs",
        appId: "1:772037083803:android:41b5ebb25599bc456fbc3e",
        messagingSenderId: "772037083803",
        projectId:"finalproject-f4c37",
        databaseURL: 'https://finalproject-f4c37-default-rtdb.asia-southeast1.firebasedatabase.app/'
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WidgetTree(),
      routes: {
        '/login': (context) => LoginPage(),
        '/report': (context) => ReportScreen(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfileScreen(),
        '/otherReport' : (context) => OtherReportScreen(),
        //'/reportQC': (context) => ReportQCScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}