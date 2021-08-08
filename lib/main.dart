import 'package:flutter/material.dart';
import 'package:offline_english_malayalam_dictionary/views/Home.dart';
import 'package:offline_english_malayalam_dictionary/views/MalayalamToEnglish.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Malayalam Dictionary',
      routes: {
        '/': (context) => const Home(title: 'English Malayalam Dictionary'),
        '/malayalam': (context) =>
            const MalayalamToEnglish(title: 'Malayalam English Dictionary')
      },
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: Colors.deepPurple[400],
        primaryColorLight: Colors.deepPurple[50],
        accentColor: Colors.white,
        errorColor: Colors.red[600],
        primarySwatch: Colors.purple,
      ),
    );
  }
}
