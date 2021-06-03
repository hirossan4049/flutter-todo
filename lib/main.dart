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

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _text = "";
  var _controller = TextEditingController();
  var listViewKey = Key("listView");
  List<Color> colorList = [Colors.cyan, Colors.deepOrange, Colors.indigo];
  List<String> lists = ["hello", "world", "hey"];

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

  void add() {
    setState(() {
      // lists.add(_text);
      lists.insert(0, _text);
      _controller.clear();
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
                    controller: _controller,
                    onChanged: _handleText,
                  )),
                  RaisedButton(
                      child: const Text("追加",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      color: Colors.white,
                      shape: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      onPressed: add),
                  // HomeWidget()
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                  key: listViewKey,
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(lists[index]);
                    return _buildRow(index, lists[index]);
                  },
                  itemCount: lists.length),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(int index, String title) {
    return Dismissible(
        key: Key("$index"),
        background: Container(color: Colors.red),
        // start to endの背景
        secondaryBackground: Container(color: Colors.yellow),
        // end to startの背景
        onDismissed: (direction) {
          print("deleted $index $direction $lists");

          setState(() {
            lists.removeAt(index);
            // lists.remove(title);
          });

          print("remove at $index, $lists");
          if (direction == DismissDirection.endToStart) {
            print("end to start"); // (日本語だと)右から左のとき
          } else {
            print("start to end"); // (日本語だと?)左から右のとき
          }
        },
        child:
    // Container(
    //         height: 32,
    //         margin: EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 4),
    //         child:

            // Row(
            //     children: [
            //       Icon(Icons.check_box_outline_blank),
            //       Text(
            //         title,
            //         style: TextStyle(fontSize: 20),
            //       )
            //     ]))
        ListTile(
          title: Text(title),
          onTap: () {
            print("row clicked");
          },
          // trailing: Icon(Icons.check_box_outline_blank),
          leading: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: 44,
                  minWidth: 34,
                  maxHeight: 64,
                  maxWidth: 54),
              child: Icon(Icons.check_box_outline_blank)),
        ),
        );
  }
}
