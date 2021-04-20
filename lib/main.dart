import 'dart:developer';

//import 'package:calculator/logiccalc.dart';
import 'package:calculator/pages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'gate.dart';



Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/ history.txt');
}

Future<File> writeCounter(String question) async {
  final file = await _localFile;

  // Write the file.
  return file.writeAsString('$question');
}

Future<int> readCounter() async {
  try {
    final file = await _localFile;

    // Read the file.
    String contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0.
    return 0;
  }
}

void main() {
  runApp(MyApp());
}
SharedPreferences prefs;
class MyApp extends StatelessWidget {
  static Future init() async{
    prefs = await SharedPreferences.getInstance();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        MyHomePage.routeName: (context) => MyHomePage(
              title: 'hi?',
            ),
   //     Logic.routeName: (context) => Logic(),
        Pages.routeName: (context) => Pages(),
        Gate.routeName: (context) => Gate()
      },
      initialRoute: MyHomePage.routeName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String routeName = "/";
  MyHomePage({this.title,this.app});
  final String title;
  final FirebaseApp app;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var question = '';
  var answer = 'please click the menu button before clicking on ans for it to appear in history';
  final referenceDataBase = FirebaseDatabase.instance;
    SharedPreferences sharedPreferences;
  @override
  void initState() {
   
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    final _ref = database.reference().child('History');
    loadSharedPreferences();
    super.initState();
  }

  void loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  final List<String> cButtons = [
    //  'NULL',
    //  'NULL',
    '^',
    '/',
    '*',
    'ANS',
    '9',
    '8',
    '7',
    '+',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    'del',
    // '<=',
    // '>=',
    '.',
    '0',
    // '~',
    //'|',
    //'&',
    '%',
    'C',
    'history'
    //'<',
    //'>',
    //'=='
  ];

  @override
  Widget build(BuildContext context) {
    final _ref = referenceDataBase.reference().child('History');
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    //   final _ref = database.reference().child('History');
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
              _ref
                          .child('History')
                          .push()
                          .child('question')
                          .set(question)
                          .asStream();
              //  Navigator.pushNamed(context, Pages.routeName);
              },
            );
          },
        ),
        title: Text(
          '<-logic calc) "Calculator"',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        question,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[100], shape: BoxShape.rectangle),
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: cButtons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 3) {
                      return MyButton(cButtons[index], Colors.green, () {
                        setState(() {
                          solve();
                          
                        });
                      });
                    } else if (index == 15) {
                      return MyButton(cButtons[index], Colors.red[500], () {
                        setState(() {
                          question = question.substring(0, question.length - 1);
                        });
                      });
                       }else if (index == 20) {
                      return MyButton(cButtons[index], Colors.green[500], () {
                        setState(() {
                          Flexible(
                            child: FirebaseAnimatedList(
                              shrinkWrap: true,
                              query : _ref,
                            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                            return new ListTile(
                            trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                              _ref.child(snapshot.key).remove();
                              },
                            ),
                            title: new Text(snapshot.value[question]),
                          );
                          },
                          ));
                        });
                      });}
                     else if (index == 19) {
                      return MyButton(cButtons[index], Colors.red[600], () {
                        setState(() {
                          question = '';
                        });
                      });
                    } else {
                      return MyButton(
                          cButtons[index],
                          isOperator(cButtons[index])
                              ? Colors.lightBlue[300]
                              : Colors.blueGrey, () {
                        setState(() {
                          question += cButtons[index];
                        });
                      });
                    }
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('logic'),
        onPressed: (){
        Navigator.pushNamed(context, Gate.routeName);
      },
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '/' ||
        x == '*' ||
        x == '+' ||
        x == '-' ||
        x == '|' ||
        x == '&' ||
        x == '<=' ||
        x == '>=' ||
        x == '(' ||
        x == ')' ||
        x == '<>' ||
        x == '^' ||
        x == '~' ||
        x == '<' ||
        x == '>' ||
        x == '==') {
      return true;
    }
    return false;
  }

  void solve() {
    final solveString = question;
    //  bool x = check();
    //if (x == true) {bit();}
    Parser p = Parser();
    Expression exp = p.parse(solveString);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = '$question =' + eval.toString();
    List<String> lst =[];
    lst.add(answer);
    writeCounter(question);
    
    question = '';
    // }
  }
/*
  bool check() {
    for (int i = 0; i < question.length; i++) {
      if (question.contains(cButtons[18]) ||
          question.contains(cButtons[19]) ||
          question.contains(cButtons[22]) ||
          question.contains(cButtons[23]) ||
          question.contains(cButtons[24]) ||
         // question.contains(cButtons[25]) ||
          question.contains(cButtons[27]) ||
          question.contains(cButtons[28]) ||
          question.contains(cButtons[29])) {
        bit();
        return false;
      } else
        return true;
    }
  }

  void bit() {
    final solveString = question;
    Parser q= new Parser();
    Expression exp = q.parse(solveString);
    
  }
*/

}
/*void saveData() async{
  await MyApp.init();
    prefs.setStringList('stringList', );
}
void fetch() async{
  final myStringList = prefs.getStringList('stringList') ?? [];
  log("stringList =$myStringList");
}*/
/*class Todo{
  String title;
  Todo({this.title});

  Todo.fromMap(Map map): this.title = map['title'],

  Map toMap()
  {
    return{'title': this.title,};
  }
}*/
