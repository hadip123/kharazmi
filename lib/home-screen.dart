// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kharazmi/login.dart';
import 'package:kharazmi/module.dart';
import 'package:kharazmi/register.dart';
import 'package:kharazmi/states-page.dart';

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

  Future<Map> getStates() async {
    final result = await http.get(Uri.parse('http://localhost:3000/state/get'));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(context),
        appBar: AppBar(
          title: Text('خوارزمی'),
        ),
        body: index == 0
            ? buildHomePage()
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
                    final postsRate = result['data'][index]['averageOfRates'];

                    final String stateName = result['data'][index]['name'];
                    return ListTile(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => StatePage(
                                    stateId: result['data'][index]['id'])));
                      },
                      title: Text(
                        '${index + 1} - $stateName',
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Text(
                        'تعداد پست ها: $numberPosts، رتبه پست ها: $postsRate',
                        textDirection: TextDirection.rtl,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            title: Text(
                              'پروفایل',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
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
                            decoration:
                                InputDecoration(labelText: 'نام خانوادگی'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(size.width, 40),
                                  elevation: 0,
                                  primary: Theme.of(context).primaryColor),
                              child: Text(
                                'بروزرسانی',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 16, color: Colors.white),
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
                                    .copyWith(
                                        fontSize: 16, color: Colors.white),
                              )),
                        ],
                      ),
                    ),
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

  Widget buildAboutPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              'درباره ما',
              style: Theme.of(context)
                  .appBarTheme
                  .titleTextStyle!
                  .copyWith(fontSize: 17),
              textDirection: TextDirection.rtl,
            ),
          )
        ],
      ),
    );
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
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.login)),
          title: Text(
            'ورود به حساب کاربری',
            textDirection: TextDirection.rtl,
            style: Theme.of(context)
                .appBarTheme
                .titleTextStyle!
                .copyWith(fontSize: 16),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Register()));
          },
          trailing: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.account_box_rounded)),
          title: Text(
            'ثبت نام',
            textDirection: TextDirection.rtl,
            style: Theme.of(context)
                .appBarTheme
                .titleTextStyle!
                .copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
