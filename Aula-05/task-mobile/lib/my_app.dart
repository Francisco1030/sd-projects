import 'package:flutter/material.dart';
import 'package:task/pages/form_task.dart';
import 'package:task/pages/home.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF2BB289),
        accentColor: Color(0xFF8C8BEA),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Lista de Tarefas",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                var result = await Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FormTask();
                  }),
                );
                if (result != null) {
                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Home(),
      ),
    );
  }
}
