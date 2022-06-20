import 'package:flutter/material.dart';

void main() {
  runApp(Angoman());
}

class Angoman extends StatelessWidget {
  const Angoman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Text("انجمن"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Color.fromRGBO(65, 78, 195, 76).withOpacity(1)),
        backgroundColor: Color(0xFFFAFAFA),
        body: Column(children: [
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
            margin: const EdgeInsets.all(10.0),
            child: TextField(
              textDirection: TextDirection.rtl,
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
                  hintText: 'سرنویس سوال',
                  contentPadding: EdgeInsets.all(25.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: 400,
              child: TextField(
                maxLines: null,
                minLines: null,
                expands: true,
                textDirection: TextDirection.rtl,
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
                    hintText: 'متن سوال',
                    contentPadding: EdgeInsets.all(25.0)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("ارسال سوال"),
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(65, 78, 195, 76),
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10)),
          ),
        ]),
      ),
    );
  }
}
