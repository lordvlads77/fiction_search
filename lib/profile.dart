import 'dart:convert';
import 'dart:ui';
import 'package:fiction_search/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'initScreen.dart';
import 'add_fanfics.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'user_registries.dart';
import 'package:fiction_search/CustomLoading.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool loading = true;

  List<UsersRegistry> uregistry = [];

  Future<List<UsersRegistry>> showUserdata() async {
    var url = Uri.parse('http://fictionsearch.net/fictionSearchDB/showFics.php');
    var response = await http.post(url).timeout(Duration(seconds: 90));

    final data = jsonDecode(response.body);

    List<UsersRegistry> registry = [];

    for (var data in data){
      registry.add(UsersRegistry.fromJson(data));
    }

    return registry;

    print(response.body);
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

  void _loadingwait() async {
    setState(()  {
      SmartDialog.showLoading(
        animationType: SmartAnimationType.scale,
        builder: (_) => CustomLoading(type: 1),
      );
    });
    showUserdata().then((value) {
      setState(() {
        SmartDialog.dismiss();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showUserdata().then((value){
      setState(() {
        uregistry.addAll(value);
        SmartDialog.dismiss();
        loading = false;
      });
    });
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
                      Text('',
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
                        child: Text('Your Bio here',
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
                        child: Text('Your interests here',
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
