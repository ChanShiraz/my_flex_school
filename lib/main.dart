import 'package:flutter/material.dart';
import 'package:my_flex_school/features/auth/view/login_page.dart';
import 'package:my_flex_school/features/home/view/home_page.dart';
import 'package:my_flex_school/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flex School',
      theme: themeData,
      home: const HomePage(),
    );
  }
}
