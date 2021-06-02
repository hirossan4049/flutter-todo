import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _text = "";
  List<Color> colorList = [Colors.cyan, Colors.deepOrange, Colors.indigo];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return HomeWidget();
    return Scaffold(
      appBar: AppBar(
          // title: Text(widget.title),
          ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 42,
              margin: EdgeInsets.only(left: 12, right: 12, top: 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    onChanged: _handleText,
                  )),
                  RaisedButton(
                      child: const Text("追加",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      color: Colors.white,
                      shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      onPressed: () {}),
                  // HomeWidget()
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return Text(index.toString() * 2333);
              }),
              //     ListView(
              //   children: <Widget>[
              //     Text('Item 1'),
              //     Text('Item 2'),
              //     Text('Item 3'),
              //   ],
              // )
            )
          ],
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Test"),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Text(index.toString());
      }),
    );
  }
}
