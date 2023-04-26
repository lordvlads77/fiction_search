import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class CambiarPerfil extends StatefulWidget {
  const CambiarPerfil({Key? key}) : super(key: key);

  @override
  State<CambiarPerfil> createState() => _CambiarPerfilState();
}

class _CambiarPerfilState extends State<CambiarPerfil> {
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
                horizontal: 40,
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
                        child: Container(
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
                                hintText: 'Edit your bio',
                                hintStyle: lightHintTxtF
                            ),
                          ),
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
                        child: Container(
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
                                  Icons.star_border_outlined,
                                  color: HexColor("#FFFFFF"),
                                ),
                                hintText: 'Edit your Interests',
                                hintStyle: lightHintTxtF
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          onPressed: (){
                          },
                          child: Image.asset('img/proceedIcon.png'),
                        ),
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

