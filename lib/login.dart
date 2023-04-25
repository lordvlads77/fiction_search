import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  Text('Welcome to',
                    style: greyloginStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Fiction Search',
                        style: whiteloginStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Image.asset('img/FictionSearchlogo80x73M.png'),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login',
                            style: biggerWLoginStyle,
                          ),
                          SizedBox(
                            height: 19,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Username:',
                                style: whiteusernameStyle,
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: HexColor("#888888"),
                                  borderRadius: BorderRadius.vertical(),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor("#FFFFFF"),
                                      blurRadius: 6,
                                      offset: Offset(0, 3)
                                    ),
                                  ],
                                ),
                                height: 40,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: sRegularStyle,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: HexColor("#FFFFFF"),
                                    ),
                                    hintText: 'Write your username',
                                    hintStyle: lightHintTxtF
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Password:',
                                style: whiteusernameStyle,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: HexColor("#888888"),
                                  borderRadius: BorderRadius.vertical(),
                                  boxShadow: [
                                    BoxShadow(
                                        color: HexColor("#FFFFFF"),
                                        blurRadius: 6,
                                        offset: Offset(0, 3)
                                    ),
                                  ],
                                ),
                                height: 40,
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  style: sRegularStyle,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: HexColor("#FFFFFF"),
                                      ),
                                      hintText: 'Write your password',
                                      hintStyle: lightHintTxtF,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: MaterialButton(
                                onPressed: () => print('Pressed Button'),
                              padding: EdgeInsets.only(left: 0),
                              child: Text('Forgot Password?',
                                style: sRegularStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text('New around here?',
                              style: medium23RStyle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: MaterialButton(
                              onPressed: () => print('Pressed Button'),
                              padding: EdgeInsets.only(left: 0),
                              child: Text('Sign up!',
                                style: boldItalic20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Image.asset('img/proceedIcon.png'),
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



