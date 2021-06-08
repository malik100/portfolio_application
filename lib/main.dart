import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/home_screen.dart';
import 'views/qr_screen.dart';
import 'views/repos_screen.dart';

void main() {
  runApp(MalikYurtbilirApp());
}

class MalikYurtbilirApp extends StatelessWidget {
  final String githubname = 'malik100';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(githubname),
        '/repos': (context) => ReposScreen(githubname),
        '/qr': (context) => QRScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.orange,
        textTheme: GoogleFonts.manropeTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
