import 'package:fiction_search/CustomLoading.dart';
import 'package:fiction_search/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'styles.dart';
import 'registereduser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var s_email = new TextEditingController();
  var s_username = new TextEditingController();
  var s_password = new TextEditingController();
  var s_name = new TextEditingController();
  var s_favoritefandom = new TextEditingController();

  String email = '';
  String username = '';
  String password = '';
  String name = '';
  String favoritefandom = '';

  Future uploadNewUser() async {
    print('Lista:'+email!+'--'+username!+'--'+password!+'--'+name!+'--'+favoritefandom!);

    var url = Uri.parse('http://fictionsearch.net/fictionSearchDB/uploadUsers.php');
    var response = await http.post(url, body: {
      'email' : email,
      'username' : username,
      'password' : password,
      'name' : name,
      'favoritefandom' : favoritefandom
    }).timeout(Duration(seconds: 90));

    //print(response.body);

    if(response.body == '1'){
      show_alert('Thanks for Signing up, Your account was successfully created');
      s_email.text = '';
      s_username.text = '';
      s_password.text = '';
      s_name.text = '';
      s_favoritefandom.text = '';
    }else {
      show_alert(response.body);
    }
  }

  input(email, username, password, name, favoritefandom){
    if (email == '' || username == '' || password == '' || name == '' || favoritefandom == '') {
      show_alert('You must fill all the text fields');
    }else {
      save_data(email, username, password, name, favoritefandom);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context){
            return Profile();
          }));
    }

    s_email.text = '';
    s_username.text = '';
    s_password.text = '';
    s_name.text = '';
    s_favoritefandom.text = '';
  }

  Future<void> save_data(email, username, password, name, favoritefandom) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('email', email);
    await preferences.setString('username', username);
    await preferences.setString('password', password);
    await preferences.setString('name', name);
    await preferences.setString('favoritefandom', favoritefandom);
  }

  show_alert(mensaje){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Fiction Search'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(mensaje)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
              ),
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
    uploadNewUser().then((value) {
      setState(() {
        //await Future.delayed(Duration(seconds: 2));
        SmartDialog.dismiss();
      });
    });
  }

  Future<void> show_data()async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    email = (await preferences.getString('email'))!;
    username = (await preferences.getString('username'))!;
    password = (await preferences.getString('password'))!;
    name = (await preferences.getString('name'))!;
    favoritefandom = (await preferences.getString('favoritefandom'))!;

    print('Email: '+email);
    print('Username: '+username);
    print('Password: '+password);
    print('Name:'+name);
    print('Fandom Favorito:'+favoritefandom);

    if(email != null){
      if (email != '') {
        /*Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context){
              return new Bienvenida();
            }
        ));*/
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          //TODO: Change the return class below so it returns to profile db ready
            builder: (BuildContext context){
              return NewUser();
            }
        ),
                (route) => false);
      }
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show_data();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return GestureDetector(
      onTap: (){
        final FocusScopeNode focus = FocusScope.of(context);
        if(!focus.hasPrimaryFocus && focus.hasFocus) {
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
                            Text('Sign Up',
                              style: biggerWLoginStyle,
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email:',
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
                                    controller: s_email,
                                    keyboardType: TextInputType.emailAddress,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: HexColor("#FFFFFF"),
                                        ),
                                        hintText: 'Write your Email',
                                        hintStyle: lightHintTxtF
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Username:',
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
                                    controller: s_username,
                                    keyboardType: TextInputType.text,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: HexColor("#FFFFFF"),
                                      ),
                                      hintText: 'Write your username',
                                      hintStyle: lightHintTxtF,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
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
                                    controller: s_password,
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: HexColor("#FFFFFF"),
                                      ),
                                      hintText: 'Write your password',
                                      hintStyle: lightHintTxtF,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name:',
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
                                    controller: s_name,
                                    keyboardType: TextInputType.text,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.abc_outlined,
                                          color: HexColor("#FFFFFF"),
                                        ),
                                        hintText: 'Write your Name',
                                        hintStyle: lightHintTxtF
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Favorite Fandom',
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
                                    controller: s_favoritefandom,
                                    keyboardType: TextInputType.text,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.star_border_outlined,
                                          color: HexColor("#FFFFFF"),
                                        ),
                                        hintText: 'Your Favorite Fandom',
                                        hintStyle: lightHintTxtF
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                  onPressed: (){
                                    email = s_email.text;
                                    username = s_username.text;
                                    password = s_password.text;
                                    name = s_name.text;
                                    favoritefandom = s_favoritefandom.text;

                                      if (email == '' || username == '' || password == '' || name == '' || favoritefandom == '') {
                                      show_alert('You must fill all the text fields');
                                      }else {
                                        input(email, username, password, name, favoritefandom);
                                        _showLoading();
                                      }

                                    //input(email, username, password, name, favoritefandom);
                                  },
                                child: Image.asset('img/proceedIcon.png'),
                              ),
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
      ),
    );
  }
}