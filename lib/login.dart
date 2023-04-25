import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _remember = false;
  var c_email = TextEditingController();
  var c_password = TextEditingController();

  String email = '';
  String password = '';

  input(email, password){
    if(email == '' || password == '') {
      show_alert('You must fill all the text fields');
    }else if (email != 'saga@gmail.com' && password != '123'){
      show_alert('Email or password incorrect');
    }else {

      save_data(email, password);

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context){
            return new Bienvenida();
          }
      ));
    }

    c_email.text = '';
    c_password.text = '';
  }

  Future<void> save_data(email, password) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('email', email);
    await preferences.setString('password', password);
  }

  show_alert(mensaje){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
           title: Text('REMEMBAS'),
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
                  child: Text('Accept'),
              ),
            ],
          );
        }
    );
  }

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
                                  controller: c_email,
                                  keyboardType: TextInputType.emailAddress,
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
                                  controller: c_password,
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
                            height: 30,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                                onPressed: (){
                                  email = c_email.text;
                                  password = c_password.text;

                                  input(email, password);
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
    );
  }
}



