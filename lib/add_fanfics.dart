import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class AddFanFiction extends StatefulWidget {
  const AddFanFiction({Key? key}) : super(key: key);

  @override
  State<AddFanFiction> createState() => _AddFanFictionState();
}

class _AddFanFictionState extends State<AddFanFiction> {

  var _cTitle = new TextEditingController();
  var _cLink = new TextEditingController();
  var _cDescription = new TextEditingController();

  String? _title = '';
  String? _link = '';
  String? _description = '';

  Future _uploadFanfics() async{
    print('Lista:'+_title!+'--'+_link!+'--'+_description!);

    // TODO: Remove https if it gives problems
    var dburl = Uri.parse('https://www.fictionsearch.net/fictionSearchDB/uploadFics.php');
    var response = await http.post(dburl, body: {
      '_title' : _title,
      '_link' : _link,
      'description' : _description
    }).timeout(Duration(seconds: 90));

    if (response.body == '1'){
      show_alert('Thanks, the fic has been succesfully saved on our database');
      _cTitle.text = '';
      _cLink.text = '';
      _cDescription.text = '';
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
                  Text('placeholder')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

