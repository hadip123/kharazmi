// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:http/http.dart';
import 'package:kharazmi/model.dart';
import 'package:kharazmi/module.dart';

class PostCreate extends StatefulWidget {
  String stateId;
  PostCreate({Key? key, required this.stateId}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _PostCreateState createState() => _PostCreateState(stateId);
}

class _PostCreateState extends State<PostCreate> {
  String stateId;
  _PostCreateState(this.stateId);

  StateModel selectedState = StateModel('hello', 'Hello');

  List<StateModel> states = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final Response response = await StateModule.getStates();

      if (response.statusCode == 200) {
        final List statesInner = jsonDecode(response.body)['data'];

        states = statesInner
            .map((state) => StateModel(state['id'], state['name']))
            .toList();

        selectedState = states.firstWhere((element) => element.id == stateId);

        print(selectedState.id + " - " + selectedState.name);
        setState(() {});
      }
    });
    super.initState();
  }

  final HtmlEditorController textPost = HtmlEditorController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('نوشتن'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Response response = await Post1.createPost(Post(
              stateId: selectedState.id,
              title: titleController.text,
              description: descriptionController.text,
              text: 'await textPost.getText()',
              seens: 0,
              rate: 0));

          print(jsonDecode(response.body));
        },
        child: Icon(Icons.done_outline),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextField(
              textAlign: TextAlign.right,
              controller: titleController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'سرنویس',
                hintStyle: GoogleFonts.balooBhaijaan(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionController,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'توضیحات',
                hintStyle: GoogleFonts.balooBhaijaan(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Spacer(),
                  SizedBox(
                    width: size.width / 2,
                    child: DropdownButton<String>(
                      alignment: Alignment.center,
                      items: states
                          .map((state) => DropdownMenuItem<String>(
                                child: Text(
                                  state.name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                alignment: Alignment.center,
                                value: state.id,
                              ))
                          .toList(),
                      onChanged: (value) {
                        selectedState =
                            states.firstWhere((element) => element.id == value);
                        print(selectedState.id + " - " + selectedState.name);
                        setState(() {});
                      },
                      value: selectedState.id,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'استان انتخابی شما',
                    style: GoogleFonts.balooBhaijaan(),
                  ),
                ],
              ),
            ),
            HtmlEditor(
              controller: textPost,
              htmlEditorOptions: HtmlEditorOptions(hint: 'Hello'),
              htmlToolbarOptions: HtmlToolbarOptions(
                toolbarType: ToolbarType.nativeGrid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
