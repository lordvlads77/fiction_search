import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'styles.dart';
import 'package:hexcolor/hexcolor.dart';

class EditFics extends StatefulWidget {

  String id;

  EditFics(this.id, {Key? key}) : super(key: key);

  @override
  State<EditFics> createState() => _EditFicsState();
}

class _EditFicsState extends State<EditFics> {

  var c_title = new TextEditingController();
  var c_link = new TextEditingController();
  var c_description = new TextEditingController();
  
  String? title = '';
  String? link = '';
  String? description = '';
  
  edit_fic() async {
    var url = Uri.parse('http://fictionsearch.net/fictionSearchDB/editFic.php');
    var response = await http.post(url, body: {
      'id': widget.id,
      'title' : title,
      'link' : link,
      'description' : description,
    }).timeout(Duration(seconds: 90));
    
    if (response.body == '1') {
      Navigator.of(context).pop();
      show_alert('The Details corresponding to this fic have been successfully modified');
      c_title.text == '';
      c_link.text == '';
      c_description == '';
    } else {
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
  
  Future show_ficses() async {
    var url = Uri.parse('http://fictionsearch.net/fictionSearchDB/watchFic.php');
    var response = await http.post(url, body: {
      'id' : widget.id
    }).timeout(Duration(seconds: 90));

    var data = jsonDecode(response.body);
    print(data['title']);

    c_title.text = data['title'];
    c_link.text = data['link'];
    c_description.text = data['description'];
  }

  void _showLoading() async {
    setState(() {
      var maskWidget = Container(
        width: double.infinity,
        height: double.infinity,
        child: Opacity(
          opacity: 0.6,
          child: Image.network(
            'https://w0.peakpx.com/wallpaper/31/156/HD-wallpaper-shaka-de-virgo-thumbnail.jpg',
            fit: BoxFit.fill,
          ),
        ),
      );
      SmartDialog.showLoading(maskWidget: maskWidget);
    });
    edit_fic().then((value){
      setState(() {
        SmartDialog.dismiss();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show_ficses();
  }

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final FocusScopeNode focus = FocusScope.of(context);
        if(!focus.hasPrimaryFocus && focus.hasFocus){
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
        ),
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
                    Text('Read. Evolve',
                      style: sloganStyle,
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
                            Text('Edit Fanfics Details',
                              style: biggerWLoginStyle,
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title',
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
                                        blurRadius: 4,
                                        offset: Offset(2, 3)
                                      ),
                                    ],
                                  ),
                                  height: 40,
                                  child: TextField(
                                    controller: c_title,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.abc,
                                        color: HexColor("#FFFFFF"),
                                      ),
                                      hintText: 'Write the Title',
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
                                Text('Link',
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
                                          blurRadius: 4,
                                          offset: Offset(2, 3)
                                      ),
                                    ],
                                  ),
                                  height: 40,
                                  child: TextField(
                                    controller: c_link,
                                    keyboardType: TextInputType.url,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.link,
                                          color: HexColor("#FFFFFF"),
                                        ),
                                        hintText: 'Write the Link',
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
                                Text('Description',
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
                                          blurRadius: 4,
                                          offset: Offset(2, 3)
                                      ),
                                    ],
                                  ),
                                  height: 40,
                                  child: TextField(
                                    controller: c_description,
                                    style: sRegularStyle,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.dehaze,
                                        color: HexColor("#FFFFFF"),
                                      ),
                                      hintText: 'Write the Description',
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
                                  title = c_title.text;
                                  link = c_link.text;
                                  description = c_description.text;

                                  if (title == '' || link == '' || description == ''){
                                    show_alert('You must enter all the data');
                                  }else {
                                    edit_fic();
                                    _showLoading();
                                  }
                                },
                                child: Image.asset('img/checkmark.png'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
