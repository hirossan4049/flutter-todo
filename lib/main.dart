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
  String _updateText = "";
  var _controller = TextEditingController();
  var _updateTextController = TextEditingController();
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

  void _handleUpdateText(String e) {
    setState(() {
      _updateText = e;
    });
  }

  void add() {
    setState(() {
      // lists.add(_text);
      lists.insert(0, _text);
      _controller.clear();
    });
  }

  void update(int index, String text) {
    setState(() {
      lists[index] = text;
    });
  }

  void edit(int index, String title) {
    print("!!!!!!!!!!!!!!!!! $title");
    setState(() {
      _updateTextController.text = title;
    });
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("編集"),
          content: TextField(controller: _updateTextController, onChanged: _handleUpdateText),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
              child: Text("更新"),
              onPressed: () {
                update(index, _updateText);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
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
                  key: UniqueKey(),
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
      background: Container(
        color: Colors.blue,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
          child: Icon(Icons.edit, color: Colors.white),
        ),
      ),
      // start to endの背景
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
          child: Icon(Icons.delete_outline_rounded, color: Colors.white),
        ),
      ),

      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.startToEnd) {
          edit(index, title);
          return false;
        }else {
          return true;
        }
      },
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

        onLongPress: () {
          edit(index, title);
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
