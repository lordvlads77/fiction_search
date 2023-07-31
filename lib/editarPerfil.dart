import 'package:fiction_search/CustomLoading.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CambiarPerfil extends StatefulWidget {
  const CambiarPerfil({Key? key}) : super(key: key);

  @override
  State<CambiarPerfil> createState() => _CambiarPerfilState();
}

class _CambiarPerfilState extends State<CambiarPerfil> {

  var c_bio = new TextEditingController();
  var c_interests = new TextEditingController();


  String? bio = '';
  String? interests = '';

  Future editprofile() async{
    print('Lista:'+bio!+'--'+interests!);

    var url = Uri.parse('http://fictionsearch.net/fictionSearchDB/editarPerfil.php');
    var response = await http.post(url, body: {
      'bio' : bio,
      'interests' : interests
    }).timeout(Duration(seconds: 90));

    if (response.body == '1'){
        show_alert('Thanks, the fic has been succesfully saved on our database');
        c_bio.text = '';
        c_interests.text = '';
    }else {
        show_alert(response.body);
      }
    }

  show_alert(message){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Fiction Search'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child: Text('OK'))
            ],
          );
        }
    );
  }

  void _showLoading() async {
    setState(()  {
      SmartDialog.showLoading(
        animationType: SmartAnimationType.scale,
        builder: (_) => CustomLoading(type: 1),
      );
    });
    editprofile().then((value) {
      setState(() {
        //await Future.delayed(Duration(seconds: 2));
        SmartDialog.dismiss();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return GestureDetector(
      onTap: (){
        final FocusScopeNode focus = FocusScope.of(context);
        if(!focus.hasPrimaryFocus && focus.hasFocus){
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
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
                              controller: c_bio,
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
                              controller: c_interests,
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
                              bio = c_bio.text;
                              interests = c_interests.text;

                              if (bio == '' || interests == ''){
                                show_alert('You must enter all the data');
                              }else {
                                _showLoading();
                              }
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
      ),
    );
    }
  }

