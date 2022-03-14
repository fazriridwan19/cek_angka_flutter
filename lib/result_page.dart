import 'package:cek_angka/start_page.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String value;
  final int type;
  const ResultPage({Key? key, required this.value, required this.type})
      : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _initValue = 0;
  int _initType = 0;

  @override
  Widget build(BuildContext context) {
    _init();

    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil pengecekkan'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Angka ${widget.value} adalah",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "${getResult()}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(height: 24),
              Container(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return StartPage();
                    }), (route) => false);
                  },
                  child: Text("Kembali", style: TextStyle(fontSize: 20)),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _init() {
    _initValue = int.parse(widget.value);
    _initType = widget.type;
  }

  String getResult() {
    if (_initType == 0) {
      if (isEven(_initValue)) {
        return "Genap";
      } else {
        return "Ganjil";
      }
    } else {
      if (isPrima(_initValue)) {
        return "Prima";
      } else {
        return "Bukan Prima";
      }
    }
  }

  bool isEven(int value) {
    if (value % 2 != 0) {
      return false;
    }
    return true;
  }

  bool isPrima(int value) {
    if (value == 0 || value == 1) {
      return false;
    } else {
      for (var i = 2; i <= value / 2; i++) {
        if (value % i == 0) {
          return false;
        }
      }
    }
    return true;
  }
}
