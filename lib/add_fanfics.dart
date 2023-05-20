import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

