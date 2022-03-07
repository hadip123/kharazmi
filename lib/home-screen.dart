// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:developer';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kharazmi/about_us.dart';
import 'package:kharazmi/components/all_posts.dart';
import 'package:kharazmi/components/best_posts.dart';
import 'package:kharazmi/components/main-page.dart';
import 'package:kharazmi/config.dart';
import 'package:kharazmi/login.dart';
import 'package:kharazmi/module.dart';
import 'package:kharazmi/register.dart';
import 'package:kharazmi/states-page.dart';
import 'package:kharazmi/thelion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> states = ['خراسان شمالی', 'اردبیل'];
  final scrollController = ScrollController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  int index = 0;
  bool error = false;

  Future<Map> getStates() async {
    try {
      final result = await http.get(Uri.parse('${Configs.host}/state/get'));
      return json.decode(result.body);
    } catch (e) {
      error = true;
      setState(() {});
      return {"error": "yes"};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            build(context);
            setState(() {});
          },
          backgroundColor: Color.fromARGB(255, 66, 51, 7),
          child: Icon(Icons.update_sharp),
          elevation: 1,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        appBar: AppBar(
          title: Text('سفرینو'),
        ),
        body: buildR(context));
  }

  Widget buildR(BuildContext context) {
    return error
        ? Center(
            child: Text('اینترنتت را چک کن'),
          )
        : (index == 0
            ? MainPage(
                states: buildHomePage(),
                bestPosts: BestPosts(),
                allPosts: AllPosts(),
              )
            : index == 1
                ? buildSettingsPage(context)
                : buildAboutPage(context));
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavyBar(
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'خانه',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              textDirection: TextDirection.rtl,
            ),
            activeColor: Colors.indigoAccent.shade700),
        BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              'تنظیمات',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
              textDirection: TextDirection.rtl,
            ),
            activeColor: Colors.indigoAccent),
        BottomNavyBarItem(
            icon: Icon(Icons.info),
            title: Text(
              'درباره',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Color.fromARGB(255, 86, 96, 151),
                  ),
              textDirection: TextDirection.rtl,
            ),
            activeColor: Color.fromARGB(255, 86, 96, 151)),
      ],
      onItemSelected: (int index) => setState(() {
        this.index = index;
      }),
      selectedIndex: index,
    );
  }

  Widget buildHomePage() {
    return Container(
      child: FutureBuilder<Map>(
          future: getStates(),
          builder: (_, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              final Map result = snapshot.data!;
              return ListView.builder(
                  itemCount: result['data'].length,
                  itemBuilder: (_, int index) {
                    final int numberPosts =
                        result['data'][index]['numberOfPosts'];
                    final postsRate =
                        result['data'][index]['averageOfRates'] == 'NaN'
                            ? '0'
                            : result['data'][index]['averageOfRates'];

                    final String stateName = result['data'][index]['name'];
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        border: Border.all(
                          color: Color.fromARGB(255, 220, 218, 228),
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        stateName,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFF373737),
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        'رتبه پست ها: $postsRate',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Color(0xFF373737),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 34.0,
                                  backgroundColor:
                                      Color.fromARGB(22, 26, 66, 26),
                                  child: Image.network(
                                    (result['data'][index]['image'] ??
                                        'https://picsum.photos/45'),
                                    width: 59,
                                    height: 59,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('تعداد نوشته ها: $numberPosts'),
                          ),
                          Container(
                            margin: EdgeInsets.all(7.0),
                            width: double.infinity,
                            height: 40.0,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).secondaryHeaderColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => StatePage(
                                            stateId: result['data'][index]
                                                ['id'])));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  SizedBox(width: 20),
                                  Spacer(),
                                  Text(
                                    'دیدن نوشته ها',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.white),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                  SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget buildSettingsPage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder<http.Response>(
        future: Account.checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final http.Response response = snapshot.data!;
            if (response.statusCode == 403) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(children: [buildLoginForm(context)]));
            } else if (response.statusCode == 200) {
              final Map info = jsonDecode(response.body)['data'];
              nameController.text = info['name'];
              lastNameController.text = info['lastName'];
              return Center(
                child: SizedBox(
                  width: size.width / 1.1,
                  height: size.height / 1.3,
                  child: Card(
                    shadowColor: Colors.indigoAccent,
                    elevation: 10,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildProfileFrom(size)),
                  ),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    ;
  }

  Widget buildProfileFrom(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListTile(
          title: Text(
            'پروفایل',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl,
          ),
        ),
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'نام'),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: lastNameController,
          decoration: InputDecoration(labelText: 'نام خانوادگی'),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              final http.Response response = await Account.updateProfile(
                  nameController.text, lastNameController.text);
              if (response.statusCode == 201) {
                final success = SnackBar(
                    content: Text(
                  'عملیات موفق بود',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                      ),
                  textDirection: TextDirection.rtl,
                ));

                ScaffoldMessenger.of(context).showSnackBar(success);
              } else if (response.statusCode == 400) {
                final List<dynamic> errors =
                    jsonDecode(response.body)['message'];
                final error = SnackBar(
                    content: Text(
                  errors.join('\n'),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                      ),
                  textDirection: TextDirection.rtl,
                ));

                ScaffoldMessenger.of(context).showSnackBar(error);
              } else if (response.statusCode == 404) {}
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 40),
                elevation: 0,
                primary: Theme.of(context).primaryColor),
            child: Text(
              'بروزرسانی',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, color: Colors.white),
            )),
        Spacer(),
        ElevatedButton(
            onPressed: () async {
              await Data.remove('cookie');
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 40),
                elevation: 0,
                primary: Theme.of(context).errorColor),
            child: Text(
              'خروج',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, color: Colors.white),
            )),
      ],
    );
  }

  Widget buildAboutPage(BuildContext context) {
    return AboutUs();
  }

  Widget buildLoginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Image.asset('assets/images/login.jpg'),
        ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginPage()));
          },
          trailing: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
              child: Icon(Icons.login)),
          title: Text(
            'ورود به حساب کاربری',
            textDirection: TextDirection.rtl,
            style: Theme.of(context)
                .appBarTheme
                .titleTextStyle!
                .copyWith(fontSize: 16, color: Colors.black),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Register()));
          },
          trailing: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
              child: Icon(Icons.account_box_rounded)),
          title: Text(
            'ثبت نام',
            textDirection: TextDirection.rtl,
            style: Theme.of(context)
                .appBarTheme
                .titleTextStyle!
                .copyWith(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
