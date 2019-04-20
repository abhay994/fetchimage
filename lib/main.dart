import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Fetch(),
    );
  }
}
class Fetch extends StatefulWidget {
  @override
  _FetchState createState() => _FetchState();
}

class _FetchState extends State<Fetch> {

  //List<String> list = List();
  String img="" ;
 String txt="";
  void _getData() async {
    final response =
    await http.get(
        'https://www.bloggingbasics101.com/how-do-i-start-a-blog/');
    dom.Document document = parser.parse(response.body);
      //final elements = document.getElementsByTagName('h1');

    img = document.getElementsByTagName('img')[0].attributes['src'];
   //txt = document.getElementsByTagName('h1')[0].innerHtml.replaceAll("<span>", "").replaceAll("<"+"/"+"span>", "");
    txt = document.getElementsByTagName('h1')[0].innerHtml.replaceAll("&nbsp;", "");
    print(txt);

    setState(() {
      print(txt);
      print(img);

 /*     list = elements
          .map((element) =>
       element.getElementsByTagName("img")[0].attributes['src'])
          .toList();*/
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _getData();
              },
            ),
          ],
        ),
        body:Container(
          child: Column(
            children: <Widget>[
              Image.network(img,height: 300,width: 300),
              txt != null? Text(txt): Text("Loading..."),
            ],
          ),
        ),



    );

    }
}

