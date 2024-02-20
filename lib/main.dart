import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_log_reg/login.dart';
import 'package:hive_log_reg/user_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<User>("userData");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
