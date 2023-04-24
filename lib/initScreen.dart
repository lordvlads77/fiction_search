import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'styles.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
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
                horizontal: 20,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Fiction Search',
                    style: masterStyle,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('What are you looking for today?',
                        style: masterStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: HexColor("#FFFFFF"),
                          borderRadius: BorderRadius.vertical(),
                          boxShadow: [
                            BoxShadow(
                              color: HexColor("#C3C3C3"),
                              blurRadius: 5,
                              offset: Offset(0, 3)
                            ),
                          ],
                        ),
                        height: 35,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          style: txtSearchField,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: HexColor("#C3C3C3"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor("#4A4A4A")
                      ),
                      height: 313,
                      width: 348,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 22)),
                          Text('Most Popular: ',
                            style: mItalic,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 21.44,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('CamusxMilo 322',
                                style: regularStyle,
                                textAlign: TextAlign.center,
                              ),
                              /*Text('322',
                                style: boldStyle,
                              ),*/
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text('SagaxAioros 102',
                                style: regularStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text('Open for Love: ',
                                style: mItalic,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Text('CamusxHyoga 3',
                                style: regularStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18.14,
                          ),
                          Column(
                            children: [
                              Text('MaelxElizabeth 2',
                                style: regularStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.37,
                          ),
                          Column(
                            children: [
                              Text('ShuraxAioria 10',
                                style: regularStyle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
