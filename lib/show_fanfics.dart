import 'dart:convert';
import 'package:fiction_search/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'registries.dart';


class ShowFanfics extends StatefulWidget {
  const ShowFanfics({Key? key}) : super(key: key);

  @override
  State<ShowFanfics> createState() => _ShowFanficsState();
}

class _ShowFanficsState extends State<ShowFanfics> {

  bool loading = true;

  List<Registro> reg = [];

  Future<List<Registro>> show_fanfics() async {
    var url = Uri.parse('http://fictionsearch.net/fictionSearchDB/showFics.php');
    var response = await http.post(url).timeout(Duration(seconds: 90));

    final data = jsonDecode(response.body);

    List<Registro> registry = [];

    for (var data in data){
      registry.add(Registro.fromJson(data));
    }

    return registry;

    print(response.body);
  }

  msn_delete(id, title){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Fiction Search'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Are you sure you wanna delete?'),
                  Text(title),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
                delete_fic(id);
              },
                  child: Text('Accept')),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')
              ),
            ],
          );
        }
    );
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

  Future delete_fic(id) async {

    var url = Uri.parse('https://www.fictionsearch.net/fictionSearchDB/deleteFic.php');

    var response = await http.post(url, body: {
      'id' : id
    }).timeout(const Duration(seconds: 90));

    if (response.body == '1'){
      show_alert('The fic has been successfully deleted');
      setState(() {
        var maskWidget = Container(
          width: double.infinity,
          height: double.infinity,
          child: Opacity(
            opacity: 0.6,
            child: Image.network(
              'https://images6.fanpop.com/image/photos/40100000/Gemini-Kanon-saint-seiya-knights-of-the-zodiac-40122181-640-800.jpg',
              fit: BoxFit.fill,
            ),
          ),
        );
        SmartDialog.showLoading(maskWidget: maskWidget);
        loading = true;
        reg = [];
        show_fanfics().then((value){
          setState(() {
            reg.addAll(value);
            SmartDialog.dismiss();
            loading = false;
          });
        });
      });
    }else {
      show_alert(response.body);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show_fanfics().then((value){
      setState(() {
        reg.addAll(value);
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
      body: loading == true ?

      const Center(
        child: CircularProgressIndicator(),
      )

          : reg.isEmpty ?

      Center(
        child: Text('There is not fanfics in the database'),
      )

          : ListView.builder(
          itemCount: reg.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1,
                        color: Colors.grey
                    )
                ),
              ),
              child: Padding(padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(reg[index].title!,
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context){
                              return Placeholder();//Editar(reg[index].id!);
                            }
                        )).then((value){

                          setState(() {
                            loading = true;
                            reg = [];
                            show_fanfics().then((value){
                              setState(() {
                                reg.addAll(value);
                                loading = false;
                              });
                              // El set state sirve para redibujar o refreshear las variables que han cambiado
                            });
                          });
                        });

                      },
                      child: Icon(Icons.edit, color: Colors.green,),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        msn_delete(reg[index].id, reg[index].title);
                      },
                      child: Icon(Icons.delete, color: Colors.red,),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
