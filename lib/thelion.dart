import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          'Biology basics',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Biology &amp; The\nScientific Method',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '4 to 8 lesson',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                
                //! --------------------------------------
                Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(
                      color: Color(0xFFF6F5FA),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Color(0xFFADB5FE),
                              child: Image.network(
                                'https://i.picsum.photos/id/738/45/45.jpg?hmac=wPcNaC105ajTLHBwxdfpZICMX5IsxtzdYpKhmqrBuwA',
                                width: 45,
                                height: 45,
                                alignment: Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'FlashCards',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF373737),
                                    ),
                                  ),
                                  Text(
                                    'Introduction to Biology',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Color(0xFF373737),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        width: double.infinity,
                        child: Text(
                          'Complete the above test to unlock this one.',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(7.0),
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF5362FB),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20),
                              Spacer(),
                              Text(
                                'Begin',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              CircleAvatar(
                                backgroundColor: Color(0xFF3D50FC),
                                child: Icon(Icons.arrow_forward),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

//! --------------------------------------

                Container(
                  margin: EdgeInsets.all(20.0),
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(
                      color: Color(0xFFF6F5FA),
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Color(0xFFADB5FE),
                              child: Image.network(
                                'https://i.picsum.photos/id/738/45/45.jpg?hmac=wPcNaC105ajTLHBwxdfpZICMX5IsxtzdYpKhmqrBuwA',
                                width: 45,
                                height: 45,
                                alignment: Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quiz 2',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF373737),
                                    ),
                                  ),
                                  Text(
                                    'Controlled Experiments',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: Color(0xFF373737),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        width: double.infinity,
                        child: Text(
                          'Let\'s put your memory on our first topic to test.',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(7.0),
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF5362FB),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 20),
                              Spacer(),
                              Text(
                                'Begin',
                                style: TextStyle(color: Colors.white),
                              ),
                              Spacer(),
                              CircleAvatar(
                                backgroundColor: Color(0xFF3D50FC),
                                child: Icon(Icons.arrow_forward),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
