import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  Future<void> delete_data()async{

    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.clear();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context){
          return SignUp();
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gracias por registrarte!'),
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
