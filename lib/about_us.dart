import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.bodyText1!;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(children: [
          ListTile(
            title: Text(
              'درباره ما',
              textDirection: TextDirection.rtl,
              style: style.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'سازندگان برنامه:‌ محمدهادی پهلوان، متین پوربشیری\nاز دبیرستان تیزهوشان شهید بهشتی بجنورد (۱)\nراه های ارتباطی: ',
            style: style,
            textDirection: TextDirection.rtl,
          ),
          Row(
            children: const [Icon(Icons.message), Text('+۹۱۵۱۸۶۱۸۹۳')],
          ),
          Row(
            children: const [
              Icon(Icons.email),
              Text('safarino.app@hotmail.com')
            ],
          ),
        ]),
      ),
    );
  }
}
