import 'package:flutter/material.dart';
import 'package:portifolio/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Floriano Portifolio',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Home());
  }
}
