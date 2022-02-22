// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:kharazmi/module.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  messageBar(BuildContext context, String text) => SnackBar(
          content: Text(
        text,
        textDirection: TextDirection.rtl,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.white),
      ));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('ورود به حساب کاربری'),
      ),
      body: Center(
          child: SizedBox(
        height: 270,
        width: size.width / 1.2,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'مشخصات',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                TextField(
                  textAlign: TextAlign.right,
                  controller: username,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_box),
                      label: Text(
                        'نام کاربری',
                        style: GoogleFonts.balooBhaijaan(),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.right,
                  controller: password,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: (() {}), icon: Icon(Icons.remove_red_eye)),
                      alignLabelWithHint: true,
                      label: Text(
                        'رمز عبور',
                        style: GoogleFonts.balooBhaijaan(),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final Response response =
                        await Account.login(username.text, password.text);
                    if (response.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          messageBar(context, 'عملیات موفقیت آمیز بود'));
                      final String cookie =
                          response.headers['set-cookie'] ?? '';
                      Navigator.pop(context);
                      await Data.add('cookie', cookie);
                    } else if (response.statusCode == 401) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          messageBar(context, 'حساب کاربری یافت نشد'));
                    } 
                  },
                  child: Text('ورود',
                      style: GoogleFonts.balooBhaijaan2(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(120, 40),
                      primary: Theme.of(context).primaryColor,
                      elevation: 0),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
