import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Navigation/FrontPages.dart';
import 'package:mechily/Navigation/NavBar.dart';
import 'package:mechily/Navigation/PageNavigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // ignore: unnecessary_statements
  Get.put<Global>(Global.instance);

  runApp(
    GetMaterialApp(
      title: 'Michili',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'HNow',
          textTheme: TextTheme(bodyText2: TextStyle(fontSize: 18)),
          backgroundColor: Colors.white),
      home: PageNavigator(
        navBarConfiguration: NavBarConfiguration(),
        listOfPages: frontPages,
      ),
      // home: RestoProfileScreen(),
    ),
  );
}
