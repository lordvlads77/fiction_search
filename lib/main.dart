import 'package:fiction_search/add_fanfics.dart';
import 'package:fiction_search/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hexcolor/hexcolor.dart';
import 'initScreen.dart';
import 'login.dart';
import 'signup.dart';
import 'passwordrecovery.dart';
import 'profile.dart';
import 'editarPerfil.dart';
import 'show_fanfics.dart';
import 'editFicLink.dart';

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
       theme: ThemeData(primarySwatch: Colors.grey,
         canvasColor: HexColor("#262626")
       ),
       home: CambiarPerfil(),
       navigatorObservers: [FlutterSmartDialog.observer],
       builder: FlutterSmartDialog.init(),
     );
   }
 }

