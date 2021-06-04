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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text('Flutter todo!?'),
        ),
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
    TextEditingController _textEditingController =
        TextEditingController(text: title);
    bool editing = false;

    return Dismissible(
      key: UniqueKey(),
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
      child: ListTile(
        title: editing
            ? TextField(controller: _textEditingController, onChanged: null)
            : Text("$title"),
        onTap: () {
          print("row clicked");
          setState(() {
            editing = true;
          });
        },

        onLongPress: (){
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text("編集"),
                content: TextField(),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text("更新"),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            },
          );
        },

        // trailing: Icon(Icons.check_box_outline_blank),
        leading: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: 44, minWidth: 34, maxHeight: 64, maxWidth: 54),
            child: Icon(Icons.check_box_outline_blank)),
      ),
    );

    Widget titleWidget() {
      if (editing) {
        return TextField(controller: _textEditingController, onChanged: null);
      } else {
        return Text("$title");
      }
    }
  }
}
