import 'package:flutter/material.dart';
import 'package:kharazmi/about_us.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('درباره ما'),
        ),
        body: AboutUs());
  }
}
