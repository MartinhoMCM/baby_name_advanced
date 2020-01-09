import 'package:baby_names/Auth/login_page.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


final dummySnapshot = [
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];

 main() {
  runApp(MyApp());
}

class MyApp  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Baby Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme
        ),
      ),
//      home: MyHomePage(),
      home:LoginPage(),
    );
  }


}


