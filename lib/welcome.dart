import 'package:fiction_search/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bienvenida extends StatefulWidget {
  const Bienvenida({Key? key}) : super(key: key);

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {

  Future<void> delete_data()async{

    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.clear();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context){
          return Login();
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido de vuelta'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (){
              delete_data();

            },
            child: Text('Cerrar Sesion'
            ),
        ),
      ),
    );
  }
}