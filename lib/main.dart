// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharazmi/home-screen.dart';

void main() {
  runApp(MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
            labelStyle: GoogleFonts.notoSansArabic(), labelColor: Colors.black),
        secondaryHeaderColor: Color.fromRGBO(54, 142, 194, 76),
        textTheme: TextTheme(
            bodyText1: GoogleFonts.notoSansArabic(),
            bodyText2: GoogleFonts.balooBhaijaan2()),
        primaryColor: Color.fromARGB(255, 65, 78, 195),
        accentColor: Color(0xff2937B3),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: GoogleFonts.balooBhaijaan2(),
            errorStyle: GoogleFonts.balooBhaijaan2(),
            labelStyle: GoogleFonts.balooBhaijaan2(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(90))),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            alignLabelWithHint: true,
            focusColor: Colors.indigoAccent),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            elevation: 0,
            titleTextStyle:
                GoogleFonts.notoKufiArabic(fontSize: 20, color: Colors.white),
            backgroundColor: Color.fromRGBO(65, 78, 195, 76).withOpacity(1),
            shadowColor: Colors.white),
      )));
}
