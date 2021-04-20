import 'dart:ffi';

import 'package:flutter/material.dart';

class Gate extends StatefulWidget {
  static const String routeName = "/gate";
  @override
  _GateState createState() => _GateState();
}

class _GateState extends State<Gate> {
  double num1 = 0, num2 = 0, res = 0;

  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');

  doLessThan() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      if (num1 < num2) {
        res = 1;
      } else {
        res = 0;
      }
    });
  }

  checkEq() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      if (num1 == num2) {
        res = 1;
      } else {
        res = 0;
      }
    });
  }

  doGreaterThan() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      if (num1 > num2) {
        res = 1;
      } else {
        res = 0;
      }
    });
  }

  lessEq() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      if (num1 <= num2) {
        res = 1;
      } else {
        res = 0;
      }
    });
  }

  greaterEq() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      if (num1 >= num2) {
        res = 1;
      } else {
        res = 0;
      }
    });
  }

  and() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      if (num1 > 0 && num2 > 0) {
        res = 1;
      } else {
        res = 0;
      }
    });
  }

  or() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      if (num1 > 0 || num2 > 0) {
        res = 1;
      } else {
        res = 0;
      }
    });
  }

  negation() {
    setState(() {
      num2 = double.parse(t2.text);
      num1 = double.parse(t1.text);
      double res1 = -(num1);
      double res2 = -(num2);
      res= res1+res2;
    });
  }

  clear() {
    setState(() {
      t1 = TextEditingController(text: '');
      t2 = TextEditingController(text: '');
      res = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Logic calc'),
      ),
      body: Container(
        padding:
            EdgeInsets.only(bottom: 30.0, top: 10.0, left: 30.0, right: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                keyboardType: TextInputType.number,
                cursorColor: Colors.tealAccent,
                enabled: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Result: $res =>1-true 0-false',
                  hintStyle:
                      TextStyle(fontSize: 20.0, color: Colors.deepOrange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.tealAccent,
              controller: t1,
              decoration: InputDecoration(
                labelText: 'First value',
                fillColor: Colors.white,
                hintText: 'Enter First value',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            TextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.tealAccent,
              controller: t2,
              decoration: InputDecoration(
                labelText: 'Second value',
                fillColor: Colors.white,
                hintText: 'Enter Second value',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text('<'),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    doLessThan();
                  },
                ),
                MaterialButton(
                  child: Text('>'),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    doGreaterThan();
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text('=='),
                  color: Colors.teal,
                  shape: StadiumBorder(),
                  onPressed: () {
                    checkEq();
                  },
                ),
                MaterialButton(
                  child: Text('<='),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    lessEq();
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text('&'),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    and();
                  },
                ),
                MaterialButton(
                  child: Text('>='),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    greaterEq();
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text('|'),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    or();
                  },
                ),
                MaterialButton(
                  child: Text('~'),
                  shape: StadiumBorder(),
                  color: Colors.teal,
                  onPressed: () {
                    negation();
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text(
                    'C',
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.teal,
                  shape: StadiumBorder(),
                  padding: EdgeInsets.only(
                      left: 110.0, right: 110.0, top: 15.0, bottom: 15.0),
                  onPressed: () {
                    clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
