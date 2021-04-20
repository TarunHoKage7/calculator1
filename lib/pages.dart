//import 'package:calculator/logiccalc.dart';
import 'package:calculator/main.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'gate.dart';

class Pages extends StatefulWidget {
  static const String routeName = "/Pages";
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final List<String> allPages = [
    'arithematic calculator',
    'arithematic console calc',
    'logic console calculator',
    'history',
    'logic calculator'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          'List Of Pages',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Container(
        child: ListView(
  padding: const EdgeInsets.all(8),
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        color: Colors.amber[50],
        child: InkWell(
          onTap:(){
            Navigator.pushNamed(context, MyHomePage.routeName);
          }
        ),
        ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        color: Colors.amber[60],
        child:  InkWell(
          onTap:(){
            Navigator.pushNamed(context, Gate.routeName);
          }
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        color: Colors.amber[70],
        child:  InkWell(
          onTap:(){
            Navigator.pushNamed(context, Gate.routeName);
          }
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        color: Colors.amber[80],
        child:  InkWell(
          onTap:(){
            Navigator.pushNamed(context, MyHomePage.routeName);
          }
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        color: Colors.amber[90],
        child: InkWell(
          onTap:(){
            Navigator.pushNamed(context, MyHomePage.routeName);
          }
        ),
        ),
    ),
  ],
      
      ),
    ),
    );
       
  }
}
