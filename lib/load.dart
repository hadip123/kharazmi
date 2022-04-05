import 'package:flutter/material.dart';

class Load extends StatefulWidget {
  dynamic goToRoute;
  Load({Key? key, required this.goToRoute}) : super(key: key);

  @override
  State<Load> createState() => _LoadState(goToRoute);
}

class _LoadState extends State<Load> {
  dynamic goToRoute;
  _LoadState(this.goToRoute);
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) =>  goToRoute));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('')));
  }
}
