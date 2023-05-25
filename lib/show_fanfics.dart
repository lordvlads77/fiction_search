import 'dart:convert';
import 'package:fiction_search/editFicLink.dart';
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
                _onLoading();
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
        loading = true;
        reg = [];
        show_fanfics().then((value){
          setState(() {
            reg.addAll(value);
            loading = false;
          });
        });
      });
    }else {
      show_alert(response.body);
    }

  }

  void _onLoading() async{
    setState(() {
      var maskWidget = Container(
        width: double.infinity,
        height: double.infinity,
        child: Opacity(
          opacity: 0.6,
          child: Image.network(
            'https://img.wattpad.com/15abf3dd902ebaf15e466410d94c3990611dc1d0/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f33566f42583762507178504f34773d3d2d3334302e313534373232323363346432633864663733373638373338313139352e6a7067?s=fit&w=720&h=720',
            fit: BoxFit.fill,
          ),
        ),
      );
      SmartDialog.showLoading(maskWidget: maskWidget);
    });
    show_fanfics().then((value){
      setState(() {
        SmartDialog.dismiss(/*status: SmartStatus.loading*/);
      });
    });
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
      appBar: AppBar(
        title: Text('Added Fanfiction',
          style: sRegularStyle,
        ),
      ),
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
              child: Column(
                // TODO: Remove the line below if any layout issues occur
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15,
                        top: 10,
                        bottom: 28
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(reg[index].title!,
                      style: masterStyle,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 2,
                            color: HexColor("#888888")
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Image.network(
                                      'https://img.wattpad.com/15abf3dd902ebaf15e466410d94c3990611dc1d0/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f776174747061642d6d656469612d736572766963652f53746f7279496d6167652f33566f42583762507178504f34773d3d2d3334302e313534373232323363346432633864663733373638373338313139352e6a7067?s=fit&w=720&h=720'
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                //margin: EdgeInsets.only(top: 30, right: 19),
                                child: Expanded(
                                  child: Text(reg[index].link!,
                                    style: ficsRegularLink,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //margin: EdgeInsets.only(top: 1),
                                child: Expanded(
                                  child: Text(reg[index].description!,
                                    style: ficsRegularLink,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context){
                                        return EditFics(reg[index].id!);
                                      }
                                      )).then((value){
                                        setState(() {
                                          loading = true;
                                          reg = [];
                                          show_fanfics().then((value) {
                                            setState(() {
                                              reg.addAll(value);
                                              loading = false;
                                            });
                                          });
                                        });
                                  });
                                },
                                child: Image.asset('img/editFicIcon.png'),
                              ),
                              MaterialButton(
                                onPressed: (){
                                  msn_delete(reg[index].id, reg[index].title);
                                },
                                child: Image.asset('img/RemoveFic.png'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            );
          }
      ),
    );
  }
}
