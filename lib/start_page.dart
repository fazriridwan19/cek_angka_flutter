import 'dart:html';

import 'package:cek_angka/result_page.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String inputTeks = "";
  bool validate = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Starting Page'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_logo(), _inputNumber(), _buildBtn()],
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: const FlutterLogo(
        size: 50,
      ),
    );
  }

  Widget _inputNumber() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: TextFormField(
        enabled: true,
        onChanged: (value) {
          inputTeks = value;
        },
        decoration: InputDecoration(
          hintText: "Number",
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: (validate ? Colors.blue : Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnInput({required String titleText, required Function() makeVal}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: (validate ? Colors.blue : Colors.red),
          onPrimary: Colors.white,
        ),
        onPressed: makeVal,
        child: Text(
          titleText,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBtn() {
    return Column(
      children: [
        _btnInput(
            titleText: 'Ganjil/Genap',
            makeVal: () {
              makeValidation(0);
            }),
        _btnInput(
            titleText: 'Prima',
            makeVal: () {
              makeValidation(1);
            }),
      ],
    );
  }

  bool isNumeric(String value) {
    try {
      int.parse(value);
    } on FormatException {
      return false;
    }
    return true;
  }

  bool validation() {
    String text = "";
    if (isNumeric(inputTeks) && inputTeks != "") {
      setState(() {
        text = "Success";
      });
    } else {
      setState(() {
        text = "Failed, input must be numeric";
        if (inputTeks == "") {
          text = "Failed, require input";
        }
      });
      SnackBar snackBar = SnackBar(content: Text(text));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    SnackBar snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return true;
  }

  void makeValidation(int typeChk) {
    validate = validation();
    if (validate) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ResultPage(value: inputTeks, type: typeChk);
      }));
    }
  }
}
