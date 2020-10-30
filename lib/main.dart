import 'package:flutter/material.dart';
import 'screen/loading_screen.dart';

void main() => runApp(Movie());

class Movie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFDDE8F3),
        scaffoldBackgroundColor: Color(0xFFDDE8F3),
        splashColor: Color(0xFFAEB6BF),
        textSelectionColor: Color(0xFF384C70),
      ),
      debugShowCheckedModeBanner: false,
      home:  LoadingScreen(),
    );

  }
}


