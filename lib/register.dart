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

  bool passwordShow = true;
  bool rePasswordShow = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 13),
        child: IconButton(
          icon: Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Icon(Icons.arrow_back_ios)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: Container(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(top: 100, bottom: 100),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/logo.png',
                  //   width: 220,
                  //   height: 220,
                  // ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    margin: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if ((value ?? '').length == 0) {
                          return '???????? ??????????????';
                        }
                      },
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          hintText: '?????? ????????????',
                          contentPadding: const EdgeInsets.all(25.0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    margin: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if ((value ?? '').length == 0) {
                          return '???????? ??????????????';
                        }
                      },
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          hintText: '??????',
                          contentPadding: const EdgeInsets.all(25.0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    margin: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: lastNameController,
                      validator: (value) {
                        if ((value ?? '').length == 0) {
                          return '???????? ??????????????';
                        }
                      },
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          hintText: '?????? ????????????????',
                          contentPadding: const EdgeInsets.all(25.0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    margin: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if ((value ?? '').length == 0) {
                          return '???????? ??????????????';
                        }
                      },
                      obscureText: passwordShow,
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Color(0xFFF1F1FB), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Color(0xFFF1F1FB), width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Color(0xFFF1F1FB), width: 2.0)),
                          hintText: '?????? ????????',
                          contentPadding: const EdgeInsets.all(25.0),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordShow = !passwordShow;
                                });
                              },
                              icon: Container(
                                margin: const EdgeInsets.only(right: 20.0),
                                child: passwordShow
                                    ? const Icon(
                                        Icons.visibility,
                                        color: Colors.black87,
                                      )
                                    : const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black87,
                                      ),
                              ),
                            ),
                          )),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    margin: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: rePasswordShow,
                      controller: rePasswordController,
                      validator: (value) {
                        if ((value ?? '').length == 0) {
                          return '???????? ??????????????';
                        }
                      },
                      decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Color(0xFFF1F1FB), width: 2.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Color(0xFFF1F1FB), width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: const Color(0xFFF1F1FB), width: 2.0)),
                          hintText: '?????????? ?????? ????????',
                          contentPadding: const EdgeInsets.all(25.0),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  rePasswordShow = !rePasswordShow;
                                });
                              },
                              icon: Container(
                                margin: const EdgeInsets.only(right: 20.0),
                                child: rePasswordShow
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black87,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.black87,
                                      ),
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
                        final bool valid = _formKey.currentState!.validate();
                        if (!valid) return;
                        if (rePasswordController.text !=
                            passwordController.text) {
                          final error = SnackBar(
                            content: Text(
                                '?????? ???????? ???? ?????????? ?????? ???????? ???????????? ??????????',
                                style: GoogleFonts.balooBhaijaan2(),
                                textDirection: TextDirection.rtl),
                            duration: const Duration(seconds: 2),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(error);
                          return;
                        }
                        final Response response = await Account.register(User(
                            username: usernameController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            lastName: lastNameController.text));
                        if (response.statusCode == 201) {
                          Navigator.pop(context);
                        } else if (response.statusCode == 400) {
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
                              content: Text('?????? ???????????? ???????????? ?????? ??????',
                                  style: GoogleFonts.balooBhaijaan2(),
                                  textDirection: TextDirection.rtl));
                          ScaffoldMessenger.of(context).showSnackBar(error);
                        }
                      },
                      child: const Text('?????? ??????'),
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF1257FA),
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0))),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('???????? ???????? ???????????? ?????????? ????????'),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return SignInScreen();
                          //     },
                          //   ),
                          // );
                        },
                        child: const Text(
                          '????????',
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return ListView(
      children: [
        Column(
          children: [
            Text(
              '????????????',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if ((value ?? '').length == 0) {
                  return '???????? ??????????????';
                }
              },
              controller: usernameController,
              decoration: const InputDecoration(labelText: '?????? ????????????'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if ((value ?? '').length == 0) {
                  return '???????? ??????????????';
                }
              },
              controller: nameController,
              decoration: const InputDecoration(labelText: '??????'),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if ((value ?? '').length == 0) {
                  return '???????? ??????????????';
                }
              },
              controller: lastNameController,
              textDirection: TextDirection.rtl,
              decoration: const InputDecoration(labelText: '?????? ????????????????'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if ((value ?? '').length == 0) {
                  return '???????? ??????????????';
                }
              },
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: '?????? ????????'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if ((value ?? '').length == 0) {
                  return '???????? ??????????????';
                }
                if ((value ?? '') != passwordController.text) {
                  return '?????????? ?????? ???????? ???? ?????? ???????? ?????? ????????';
                }
              },
              controller: rePasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(labelText: '?????????? ?????? ????????'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final bool valid = _formKey.currentState!.validate();
                if (!valid) return;
                final Response response = await Account.register(User(
                    username: usernameController.text,
                    password: passwordController.text,
                    name: nameController.text,
                    lastName: lastNameController.text));
                if (response.statusCode == 201) {
                  Navigator.pop(context);
                } else if (response.statusCode == 400) {
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
                      content: Text('?????? ???????????? ???????????? ?????? ??????',
                          style: GoogleFonts.balooBhaijaan2(),
                          textDirection: TextDirection.rtl));
                  ScaffoldMessenger.of(context).showSnackBar(error);
                }
              },
              child: Text(
                '?????? ??????',
                style: GoogleFonts.balooBhaijaan2(),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  fixedSize: const Size(200, 40),
                  elevation: 0),
            )
          ],
        )
      ],
    );
  }
}
