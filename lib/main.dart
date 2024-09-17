import 'package:flutter/material.dart';
import 'package:my_flex_school/features/auth/view/login_page.dart';
import 'package:my_flex_school/features/home/view/home_page.dart';
import 'package:my_flex_school/utils/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://gwzvncpksludsysknodo.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3enZuY3Brc2x1ZHN5c2tub2RvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjExNDc5MDgsImV4cCI6MjAzNjcyMzkwOH0.ckytqoAAi3QwoH4ERpslyVeWjr0XIn-efGXs_wFVQXw",
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.implicit,
    ),
  );
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
      home: Supabase.instance.client.auth.currentUser != null
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
