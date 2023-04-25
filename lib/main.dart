import 'package:flutter/material.dart';
import 'initScreen.dart';
import 'login.dart';

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
       home: Login(),
     );
   }
 }

