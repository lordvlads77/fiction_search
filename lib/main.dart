import 'package:fiction_search/add_fanfics.dart';
import 'package:flutter/material.dart';
import 'initScreen.dart';
import 'login.dart';
import 'signup.dart';
import 'passwordrecovery.dart';
import 'profile.dart';
import 'editarPerfil.dart';
import '';

 main (){
   runApp(MainFrame());
 }

 class MainFrame extends StatelessWidget {
   const MainFrame({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'FictionSearch',
       debugShowCheckedModeBanner: false,
       theme: ThemeData(primarySwatch: Colors.grey),
       home:AddFanFiction(),
     );
   }
 }

