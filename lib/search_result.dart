import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kharazmi/config.dart';
import 'package:kharazmi/states-page.dart';

class SearchResult extends StatefulWidget {
  String searchName;
  SearchResult({Key? key, required this.searchName}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState(searchName);
}

class _SearchResultState extends State<SearchResult> {
  String searchName;

  _SearchResultState(this.searchName);
  Future<Map> getStates() async {
    try {
      final result =
          await http.get(Uri.parse('${Configs.host}/state/search/$searchName'));
      return json.decode(result.body);
    } catch (e) {
      setState(() {});
      return {"error": "yes"};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('نتایج جستجو'),
        ),
        body: Container(
          child: FutureBuilder<Map>(
              future: getStates(),
              builder: (_, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  final Map result = snapshot.data!;
                  dynamic states = result['data'];
                  return ListView.builder(
                      itemCount: states.length,
                      itemBuilder: (_, int index) {
                        final int   numberPosts = states[index]['numberOfPosts'];
                        final postsRate =
                            states[index]['averageOfRates'] == 'NaN'
                                ? '0'
                                : states[index]['averageOfRates'];

                        final String stateName = states[index]['name'];
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                        (states[index]['image'] ??
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
                                      backgroundColor: Theme.of(context)
                                          .secondaryHeaderColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      )),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => StatePage(
                                                stateId: states[index]['id'])));
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
        ));
  }
}
