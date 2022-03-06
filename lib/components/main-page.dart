// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  Widget states;
  Widget bestPosts;
  Widget allPosts;
  MainPage(
      {Key? key,
      required this.states,
      required this.bestPosts,
      required this.allPosts})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState(states, bestPosts, allPosts);
}

class _MainPageState extends State<MainPage> {
  Widget states;
  Widget allPosts;
  Widget bestPosts;
  _MainPageState(this.states, this.bestPosts, this.allPosts);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      // ignore: prefer_const_constructors
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          children: [
            Material(
              color: Theme.of(context).primaryColor.withOpacity(1),
              child: TabBar(
                indicatorColor: Colors.white,
                unselectedLabelColor: Color.fromARGB(255, 226, 223, 223),
                labelColor: Colors.white,
                tabs: [
                  Tab(text: 'استان ها'),
                  Tab(
                    text: 'برترین نوشته ها',
                  ),
                  Tab(
                    text: 'کل نوشته ها',
                  )
                ],
              ),
            ),
            SizedBox(
                height: size.height - 180,
                child: TabBarView(children: [states, bestPosts, allPosts]))
          ],
        ),
      ),
    );
  }
}
