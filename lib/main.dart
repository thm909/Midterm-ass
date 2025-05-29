import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginscreen.dart';
import 'tasklistscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTMS',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true ? tasklistscreen() : loginscreen();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
