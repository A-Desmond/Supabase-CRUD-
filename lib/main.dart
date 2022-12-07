import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:supatest/home.dart';

const databaseUrl = 'https://wuyhcuxmcnkmlfbetcyf.supabase.co';
const databaseAnnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1eWhjdXhtY25rbWxmYmV0Y3lmIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzAwMjM1MDgsImV4cCI6MTk4NTU5OTUwOH0.tfvXuZ-tGat-fRA8vf4fK65_0rsgNQ4namOFMQ4GdRQ';
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
