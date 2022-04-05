import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kharazmi/login.dart';
import 'package:kharazmi/module.dart';
import 'package:http/http.dart' as http;
import 'package:kharazmi/register.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('تنظیمات')),
        body: buildSettingsPage(context));
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
              Future.delayed(Duration.zero, () async {
                final infor = await Account.checkLogin();
              });
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
