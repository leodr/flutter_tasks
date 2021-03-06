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
        accentColor: Colors.blue[700],
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
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
        children: <Widget>[
          const SizedBox(height: 50.0),
          const Padding(
            padding: EdgeInsets.only(right: 60.0),
            child: Text(
              "Meine Aufgaben",
              style: TextStyle(
                fontSize: 32.0,
                fontFamily: 'Product Sans',
              ),
            ),
          ),
          if (todo.isEmpty && did.isEmpty)
            Expanded(
              child: Container(),
            )
          else
            Container(),
          if (todo.isEmpty && did.isEmpty)
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Image.asset(
                  "assets/picture.png",
                  width: 250.0,
                  height: 250.0,
                ),
                const Text(
                  "Ein neuer Anfang",
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 18.0,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Möchten Sie eine Aufgabe erstellen?",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            )
          else
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: todo
                          .map(
                            (s) => Dismissible(
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
                                    leading: const Icon(
                                        Icons.radio_button_unchecked),
                                    title: Text(s),
                                  ),
                                  const Divider(height: 1.0)
                                ],
                              ),
                            ),
                          )
                          .toList()
                            ..addAll(
                              did.isEmpty
                                  ? []
                                  : [
                                      Dismissible(
                                        direction: DismissDirection.startToEnd,
                                        background:
                                            Container(color: Colors.red),
                                        key: const Key("Erledigt"),
                                        onDismissed: (direction) {
                                          setState(() {
                                            did = [];
                                          });
                                        },
                                        child: ExpansionTile(
                                          title: Text(
                                            "Erledigt (${did.length})",
                                            style: const TextStyle(
                                              fontFamily: 'Product Sans',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          children: did
                                              .map(
                                                (s) => ListTile(
                                                  title: Text(s),
                                                  leading: const Icon(Icons
                                                      .check_circle_outline),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          if (todo.isEmpty && did.isEmpty)
            Expanded(child: Container())
          else
            Container()
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: Theme.of(context).accentColor,
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                const Text(
                  "Neue Aufgabe hinzufügen",
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
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
                const BorderRadius.vertical(top: Radius.circular(6.0)),
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
                        fontSize: 14.0,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  const ListTile(
                    trailing: Icon(Icons.check),
                    title: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Meine Reihenfolge",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Datum",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  const Divider(),
                  Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      const ListTile(
                        title: Text(
                          "Liste umbenennen",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      const ListTile(
                        title: Text(
                          "Liste löschen",
                          style: TextStyle(fontSize: 15.0, color: Colors.grey),
                        ),
                      ),
                      ListTile(
                        onTap: did.isEmpty
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
                            color: did.isEmpty ? Colors.grey : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void buildNewSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: <Widget>[
          Expanded(child: Container()),
          Material(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(6.0),
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: controller,
                  autofocus: true,
                  style: const TextStyle(
                    fontFamily: 'Product Sans',
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 20.0,
                      left: 24.0,
                      right: 24.0,
                      bottom: 12.0,
                    ),
                    border: InputBorder.none,
                    hintText: "Neue Aufgabe",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.blue[600].withOpacity(0.17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
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
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
              ],
            ),
          ),
        ],
      ),
    );
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
                const SizedBox(height: 8.0),
                ListTile(
                    leading: const CircleAvatar(
                        radius: 24.0,
                        child: Text(
                          "M",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
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
                                  color: Colors.grey[700], fontSize: 14.0),
                            ),
                            const Icon(Icons.keyboard_arrow_down)
                          ],
                        )
                      ],
                    )),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 55.0,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(0.2),
                        borderRadius: const BorderRadius.horizontal(
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
                const Divider(),
                const ListTile(
                    leading: Icon(Icons.add),
                    title: Text("Neue Liste erstellen")),
                const Divider(),
                const ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text("Feedback geben")),
                const Divider(),
                const ListTile(title: Text("Open Source-Lizenzen")),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
