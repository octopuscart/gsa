import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:gsa/initPage.dart';
import 'package:gsa/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gospal Sharing App',
      // theme: ThemeData(

      //   primarySwatch: Colors.blue,
      // ),
      home: const InitPage(title: 'Flutter Demo Home Page'),
      initialRoute: 'initpage',
      routes: {
        'initpage': (context) => InitPage(title: 'GSA Init Page'),
        'home': (context) => MyHomePage(title: 'GSA Home Page'),
      },
    );
  }
}
