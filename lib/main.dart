import 'package:flutter/material.dart';
import 'package:save_websites_with_hive/src/models/website.dart';
import 'package:save_websites_with_hive/src/screens/login_screen.dart';
// TODO 3 : Import Hive and hive_flutter
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // TODO 4 : Initialize Binding
  WidgetsFlutterBinding.ensureInitialized();

  // TODO 5 : Initialize Hive
  await Hive.initFlutter();

  // TODO 8 : Register Adapter
  Hive.registerAdapter(WebsiteAdapter());

  //TODO 9 : Open the Box
  /// Box is the place where data is stored in hive
  /// Box using key value pairs storage mechanism
  await Hive.openBox<Website>('websites');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save websites with hive database',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
