import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'styles.dart';
import 'registereduser.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var s_email = TextEditingController();
  var s_username = TextEditingController();
  var s_password = TextEditingController();

  String email = '';
  String username = '';
  String password = '';

  input(email, username, password){
    if (email == '' || username == '' || password == '') {
      show_alert('You must fill all the text fields');
    }else {
      save_data(email, username, password);

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (BuildContext context){
            return NewUser();
          }
      ),
              (route) => false);
    }

    s_email.text = '';
    s_username.text = '';
    s_password.text = '';
  }

  Future<void> save_data(email, username, password) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString('email', email);
    await preferences.setString('username', username);
    await preferences.setString('password', password);
  }

  show_alert(mensaje){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Attention:'),
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

  Future<void> show_data()async {

    SharedPreferences preferences = await SharedPreferences.getInstance();

    email = (await preferences.getString('email'))!;
    username = (await preferences.getString('username'))!;
    password = (await preferences.getString('password'))!;

    print('Email: '+email);
    print('Username: '+username);
    print('Password: '+password);

    if(email != null){
      if (email != '') {
        /*Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context){
              return new Bienvenida();
            }
        ));*/
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
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
                            height: 60,
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                                onPressed: (){
                                  email = s_email.text;
                                  username = s_username.text;
                                  password = s_password.text;

                                  input(email, username, password);
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