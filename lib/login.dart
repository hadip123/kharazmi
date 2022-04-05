import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:http/http.dart';
import 'package:kharazmi/module.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final IconData passwordIconOff = Icons.visibility_off;
  final IconData passwordIconOn = Icons.visibility;
  final username = TextEditingController();
  final password = TextEditingController();
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 13),
        child: IconButton(
          icon: Container(
              margin: EdgeInsets.only(left: 5),
              child: Icon(Icons.arrow_back_ios)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            //   width: 220,
            //   height: 220,
            // ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
              margin: EdgeInsets.all(10.0),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF1F1FB), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF1F1FB), width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF1F1FB), width: 2.0)),
                    hintText: 'نام کاربری',
                    contentPadding: EdgeInsets.all(25.0)),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
              margin: EdgeInsets.all(10.0),
              child: TextField(
                controller: password,
                obscureText: showPassword,
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF1F1FB), width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF1F1FB), width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:
                            BorderSide(color: Color(0xFFF1F1FB), width: 2.0)),
                    hintText: 'رمز عبور',
                    contentPadding: EdgeInsets.all(25.0),
                    suffixIcon: Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword ? passwordIconOn : passwordIconOff,
                          color: Colors.black87,
                        ),
                      ),
                    )),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () async {
                  final Response response =
                      await Account.login(username.text, password.text);
                  if (response.statusCode == 201) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        messageBar(context, 'عملیات موفقیت آمیز بود'));
                    final String cookie = response.headers['set-cookie'] ?? '';
                    Navigator.pop(context);
                    await Data.add('cookie', cookie);
                  } else if (response.statusCode == 401) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        messageBar(context, 'حساب کاربری یافت نشد'));
                  }
                },
                child: Text(
                  'ورود',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white, fontSize: 19),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1257FA),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0))),
              ),
            ),
            Text('حساب کاربری ندارید؟'),
            TextButton(
              style: TextButton.styleFrom(primary: primaryColor),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return SignUpScreen();
                //     },
                //   ),
                // );
              },
              child: Text('ثبت نام',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: primaryColor)),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar messageBar(BuildContext context, String message) {
    return SnackBar(
        content: Text(
      message,
      style:
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
    ));
  }
}
