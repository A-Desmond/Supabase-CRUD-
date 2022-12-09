import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:supatest/home.dart';

const databaseUrl = 'paste url databse url here';
const databaseAnnonKey = 'paste your annon key here'
void main() async  {
   WidgetsFlutterBinding.ensureInitialized();
   await Supabase.initialize(
    url:databaseUrl ,
    anonKey: databaseAnnonKey,
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const  HomePage(),
    );
  }
}
