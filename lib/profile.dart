import 'dart:ui';

import 'package:fiction_search/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'initScreen.dart';
import 'add_fanfics.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: HexColor("#262626")
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('img/ProfilePicM.png'),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('KuranKaname01',
                        style: boldItalic30,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Bio',
                          style: mItalic25,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Lorem Ipsun sit dolor amet',
                          style: light25,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Interests:',
                          style: mItalic25,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Lorem Ipsun sit dolor amet',
                          style: light25,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context){
                                        return InitScreen();
                                      }));
                                },
                                child: Image.asset('img/homeIconM.png'),
                              ),
                              MaterialButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context){
                                        return AddFanFiction();
                                      }));
                                },
                                child: Image.asset('img/addFics.png'),
                              ),
                              /*MaterialButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context){
                                        return Placeholder();
                                      }));
                                },
                                child: Image.asset('img/favsUser.png'),
                              ),*/
                              /*Container(
                                padding: EdgeInsets.only(
                                  left: 40,
                                ),
                              ),*/
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
