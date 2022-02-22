// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kharazmi/home-screen.dart';

void main() {
  runApp(MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText1: GoogleFonts.notoSansArabic(),
            bodyText2: GoogleFonts.balooBhaijaan2()),
        primaryColor: Colors.indigoAccent,
        inputDecorationTheme: InputDecorationTheme(
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
            elevation: 0,
            titleTextStyle: GoogleFonts.notoKufiArabic(fontSize: 20),
            backgroundColor: Colors.indigoAccent,
            shadowColor: Colors.white),
      )));
}
