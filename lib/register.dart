import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:kharazmi/model.dart';
import 'package:kharazmi/module.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت نام کاربر'),
      ),
      body: Center(
          child: SizedBox(
        width: size.width / 1.5,
        height: 500,
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text(
                        'مشخصات',
                        style: Theme.of(context).appBarTheme.titleTextStyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if ((value ?? '').length == 0) {
                            return 'چیزی بنویسید';
                          }
                        },
                        controller: usernameController,
                        decoration:
                            const InputDecoration(labelText: 'نام کاربری'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if ((value ?? '').length == 0) {
                            return 'چیزی بنویسید';
                          }
                        },
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'نام'),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if ((value ?? '').length == 0) {
                            return 'چیزی بنویسید';
                          }
                        },
                        controller: lastNameController,
                        textDirection: TextDirection.rtl,
                        decoration:
                            const InputDecoration(labelText: 'نام خانوادگی'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if ((value ?? '').length == 0) {
                            return 'چیزی بنویسید';
                          }
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'رمز عبور'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if ((value ?? '').length == 0) {
                            return 'چیزی بنویسید';
                          }
                          if ((value ?? '') != passwordController.text) {
                            return 'تکرار رمز عبور با رمز عبور یکی نیست';
                          }
                        },
                        controller: rePasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'تکرار رمز عبور'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final bool valid = _formKey.currentState!.validate();
                          print(valid);
                          if (!valid) return;
                          final Response response = await Account.register(User(
                              username: usernameController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              lastName: lastNameController.text));
                          print(response.statusCode);

                          if (response.statusCode == 201) {
                            print(jsonDecode(response.body));
                            Navigator.pop(context);
                          } else if (response.statusCode == 400) {
                            print(jsonDecode(response.body));
                            List errors = jsonDecode(response.body)['message'];
                            final error = SnackBar(
                              content: Text(errors.join('\n'),
                                  style: GoogleFonts.balooBhaijaan2(),
                                  textDirection: TextDirection.rtl),
                              duration: Duration(seconds: errors.length * 2),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(error);
                          } else if (response.statusCode == 402) {
                            final error = SnackBar(
                                content: Text('نام کاربری انتخاب شده است',
                                    style: GoogleFonts.balooBhaijaan2(),
                                    textDirection: TextDirection.rtl));
                            ScaffoldMessenger.of(context).showSnackBar(error);
                          }
                        },
                        child: Text(
                          'ثبت نام',
                          style: GoogleFonts.balooBhaijaan2(),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            fixedSize: Size(200, 40),
                            elevation: 0),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
