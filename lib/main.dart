// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  TestState createState() => TestState();
}

class TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: const Center(
            child: Text("TEST",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                color: Colors.black,
                icon: const Icon(Icons.settings),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
        ),
        endDrawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        // ignore: prefer_const_constructors
                        Text(
                          "AYARLAR",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                  ),
                ),
                ExpansionTile(
                  backgroundColor: Colors.white70,
                  leading: const Icon(
                    Icons.device_hub,
                    color: Colors.teal,
                  ),
                  title: const Text(
                    'Ayarlar',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: const Icon(
                    Icons.arrow_right,
                    color: Colors.teal,
                  ),
                  children: <Widget>[
                    ExpansionTile(
                      title: const Text(
                        'Kutu',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextButton(
                                onPressed: () {
                                  navigateToSubPage(context);
                                },
                                child: const Text(
                                  "Kutu Adını değiştir",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text(
                        'Su Deposu',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextButton(
                                onPressed: () {
                                  navigateTankPage(context);
                                },
                                child: const Text(
                                  "Su deposu adını değiştir",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextButton(
                                onPressed: () {
                                  navigateTankOranPage(context);
                                },
                                child: const Text(
                                  "Doluluk oranını ayarla",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    StreamBuilder<DatabaseEvent>(
                      stream: FirebaseDatabase.instance
                          .ref()
                          .child("suDeposu")
                          .onValue,
                      builder: (BuildContext? context,
                          AsyncSnapshot<DatabaseEvent>? event) {
                        Map<dynamic, dynamic> data =
                            event?.data?.snapshot.value as Map;

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 40),
                              child: Text(
                                "${data['ad']}",
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 120,
                              margin: const EdgeInsets.only(
                                top: 10,
                                left: 40,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: LiquidLinearProgressIndicator(
                                value: double.parse("${data['dolulukOranı']}") /
                                    100,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.blue),
                                backgroundColor: Colors.white,
                                borderColor: Colors.teal.shade100,
                                borderWidth: 5.0,
                                borderRadius: 12.0,
                                direction: Axis.vertical,
                                center: Text(
                                  "Doluluk oranı:" +
                                      "${data['dolulukOranı']}".toString() +
                                      "%",
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    StreamBuilder<DatabaseEvent>(
                      stream:
                          FirebaseDatabase.instance.ref().child("kutu").onValue,
                      builder: (BuildContext context,
                          AsyncSnapshot<DatabaseEvent> event) {
                        Map<dynamic, dynamic> data =
                            event.data!.snapshot.value as Map;

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 60),
                              child: Text(
                                "${data['ad']}",
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 70,
                              width: 120,
                              margin: const EdgeInsets.only(
                                top: 10,
                                left: 60,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.zero),
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              child: LinearProgressIndicator(
                                value: 0.2,
                                backgroundColor: Colors.white,
                                color: Colors.yellow.shade700,
                                minHeight: 30,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }

  Future navigateTankPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Page()));
  }

  Future navigateTankOranPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OranPage()));
  }
}

class SubPage extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref();
  late String newValue;

  SubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TEST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(),
              onChanged: (value) => newValue = value,
            ),
            ElevatedButton(
              child: const Text('KAYDET'),
              onPressed: () {
                updateData();
              },
            )
          ],
        ),
      ),
    );
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }

  void updateData() {
    databaseReference.child("box").update({'ad': newValue});
  }
}

class Page extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref();
  late String newValue;

  Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TEST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(),
              onChanged: (value) => newValue = value,
            ),
            ElevatedButton(
              child: const Text('KAYDET'),
              onPressed: () {
                updateData();
              },
            )
          ],
        ),
      ),
    );
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }

  void updateData() {
    databaseReference.child("suDeposu").update({'ad': newValue});
  }
}

@immutable
class OranPage extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref();
  late String newValue;

  OranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' TEST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(),
              onChanged: (value) => newValue = value,
            ),
            ElevatedButton(
              child: const Text('KAYDET'),
              onPressed: () {
                updateData();
              },
            )
          ],
        ),
      ),
    );
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }

  void updateData() {
    databaseReference.child("suDeposu").update({'dolulukOranı': newValue});
  }
}
