import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Api Call'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List? data;

  Future<String> getData() async {
    Uri url = Uri.parse("http://sanashar.com/api/Product/GetAllProducts");

    var response = await http.get(url, headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Api Example"),
      ),
      body: Center(
        child: getList(),
      ),
    );
  }

  Widget getList() {
    int size = 0;
    if (data != null) {
      size = data!.length;
    }
    if (data == null || size < 1) {
      return Container(
        child: Center(
          child: Text("Please wait..."),
        ),
      );
    }

    return ListView.separated(
      itemCount: size,
      itemBuilder: (BuildContext context, int index) {
        return getListItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget getListItem(int i) {
    int size = 0;
    if (data != null) {
      size = data!.length;
    }

    if (data == null || size < 1)
      return Container(
        child: Text("...."),
      );
    if (i == 0) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Center(
          child: Text(
            "Flutter Items",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                  child: Text(data![i]['Name'].toString(),
                      style: TextStyle(
                        fontSize: 18,
                      ))),
              Expanded(
                child: Image(
                  image: NetworkImage(
                      "http://sanashar.com" + data![i]['URL'].toString()),
                  height: 64,
                  width: 64,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
