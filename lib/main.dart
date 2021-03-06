import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tasks',
      color: Colors.white,
      theme: ThemeData(
          primaryColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800], opacity: 1.0),
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          accentColor: Colors.blue[700]),
      home: MyHomePage(),
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
  List<String> todo = [];

  List<String> did = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Text("Meine Aufgaben",
                style: TextStyle(fontSize: 32.0, fontFamily: 'Product Sans')),
          ),
          todo.length < 1 && did.length < 1
              ? Expanded(
                  child: Container(),
                )
              : Container(),
          todo.length < 1 && did.length < 1
              ? Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Image.asset("assets/picture.png",
                        width: 250.0, height: 250.0),
                    Text(
                      "Ein neuer Anfang",
                      style: TextStyle(
                          fontFamily: 'Product Sans',
                          fontSize: 18.0,
                          letterSpacing: -0.4),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Möchten Sie eine Aufgabe erstellen?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                )
              : Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: todo
                              .map((s) => Dismissible(
                                    key: Key(s),
                                    onDismissed: (direction) {
                                      setState(() {
                                        did.add(s);
                                        todo.remove(s);
                                      });
                                    },
                                    direction: DismissDirection.startToEnd,
                                    background: Container(
                                        color: Theme.of(context).accentColor),
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: Icon(
                                              Icons.radio_button_unchecked),
                                          title: Text(s),
                                        ),
                                        Divider(height: 1.0)
                                      ],
                                    ),
                                  ))
                              .toList()
                                ..addAll(did.length < 1
                                    ? []
                                    : [
                                        Dismissible(
                                          direction:
                                              DismissDirection.startToEnd,
                                          background:
                                              Container(color: Colors.red),
                                          key: Key("Erledigt"),
                                          onDismissed: (direction) {
                                            setState(() {
                                              did = [];
                                            });
                                          },
                                          child: ExpansionTile(
                                            title: Text(
                                              "Erledigt (" +
                                                  did.length.toString() +
                                                  ")",
                                              style: TextStyle(
                                                  fontFamily: 'Product Sans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            children: did
                                                .map((s) => ListTile(
                                                      title: Text(s),
                                                      leading: Icon(Icons
                                                          .check_circle_outline),
                                                    ))
                                                .toList(),
                                          ),
                                        )
                                      ]),
                        ),
                      )
                    ],
                  ),
                ),
          todo.length < 1 && did.length < 1
              ? Expanded(child: Container())
              : Container()
        ],
      ),
      floatingActionButton: RaisedButton(
        highlightColor: Colors.white.withOpacity(0.15),
        splashColor: Colors.white.withOpacity(0.07),
        elevation: 6.0,
        highlightElevation: 10.0,
        onPressed: () {
          buildNewSheet();
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        color: Theme.of(context).accentColor,
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Neue Aufgabe hinzufügen",
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 55.0,
        child: Material(
          color: Colors.white,
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.grey[700]),
                  onPressed: () {
                    buildNavigationSheet();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[700]),
                  onPressed: () {
                    buildOptionSheet();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buildOptionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: <Widget>[
                Expanded(child: Container()),
                Material(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(6.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 25.0, bottom: 10.0),
                          child: Text(
                            "Sortieren nach",
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[800]),
                          ),
                        ),
                        ListTile(
                            trailing: Icon(Icons.check),
                            title: Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Text(
                                "Meine Reihenfolge",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        ListTile(
                            title: Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Text(
                            "Datum",
                            style: TextStyle(),
                          ),
                        )),
                        Divider(),
                        Flex(
                          direction: Axis.vertical,
                          children: <Widget>[
                            ListTile(
                                title: Text(
                              "Liste umbenennen",
                              style: TextStyle(fontSize: 15.0),
                            )),
                            ListTile(
                                title: Text(
                              "Liste löschen",
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.grey),
                            )),
                            ListTile(
                                onTap: did.length < 1
                                    ? null
                                    : () {
                                        setState(() {
                                          did = [];
                                          Navigator.of(context).pop();
                                        });
                                      },
                                title: Text(
                                  "Alle erledigten Aufgaben löschen",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: did.length < 1
                                          ? Colors.grey
                                          : Colors.black),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  void buildNewSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: <Widget>[
                Expanded(child: Container()),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(6.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: controller,
                        autofocus: true,
                        style: TextStyle(
                            fontFamily: 'Product Sans',
                            color: Colors.black,
                            fontSize: 18.0),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 20.0,
                                left: 24.0,
                                right: 24.0,
                                bottom: 12.0),
                            border: InputBorder.none,
                            hintText: "Neue Aufgabe"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                              Icons.add_circle,
                              color: Theme.of(context).accentColor,
                            )),
                            FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor:
                                  Colors.blue[600].withOpacity(0.17),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                setState(() {
                                  todo.add(controller.text);
                                });
                                Navigator.of(context).pop();
                                controller.clear();
                              },
                              child: Text(
                                "Speichern",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Product Sans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                    ],
                  ),
                )
              ],
            ));
  }

  void buildNavigationSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              children: <Widget>[
                Expanded(child: Container()),
                Material(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      ListTile(
                          leading: CircleAvatar(
                              radius: 24.0,
                              child: Text(
                                "M",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Max Mustermann",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Product Sans',
                                    fontSize: 14.0),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "example@gmail.com",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14.0),
                                  ),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              )
                            ],
                          )),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, top: 10.0, bottom: 10.0),
                        child: Container(
                          height: 55.0,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(30.0))),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  "Meine Aufgaben",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                      ),
                      Divider(),
                      ListTile(
                          leading: Icon(Icons.add),
                          title: Text("Neue Liste erstellen")),
                      Divider(),
                      ListTile(
                          leading: Icon(Icons.feedback),
                          title: Text("Feedback geben")),
                      Divider(),
                      ListTile(title: Text("Open Source-Lizenzen")),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Datenschutzerklärung"),
                            SizedBox(width: 8.0),
                            Icon(
                              Icons.brightness_1,
                              size: 2.0,
                            ),
                            SizedBox(width: 8.0),
                            Text("Nutzungsbedingungen")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}
