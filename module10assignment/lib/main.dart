import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(UserProfileApp());
}

class UserProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}
