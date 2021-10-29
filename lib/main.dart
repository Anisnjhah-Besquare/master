import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
// is not restarted.
primarySwatch: Colors.blue,
),
home: MyHomePage(title: 'Flutter Demo Home Page'),
);
}
}

class MyHomePage extends StatefulWidget {
MyHomePage({Key? key, required this.title}) : super(key: key);

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


    List _items = [];

//Fetch content from json file
    Future<void>readJson()async{
      final dynamic response = await rootBundle.loadString('/samples.json');
      final data = await jsonDecode(response);
      setState(() {
      _items = data;
       }
      );
      print(_items[5].containsKey("avatar") );
    }

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(widget.title),
      ),
    body: Center(
  
  child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     mainAxisSize: MainAxisSize.max,
  children: [
       ElevatedButton(
              child: const Text('Display Data'),
              onPressed: readJson,
            ),
//Display data loaded from json file
      _items.isNotEmpty ? Expanded(
      child: ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context,index){
    return Row(
//margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

  //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children:<Widget> [
              Padding(padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: _items[index].containsKey("avatar") ? NetworkImage(_items[index]["avatar"]) : NetworkImage("https://www.vhv.rs/dpng/d/526-5268314_empty-avatar-png-user-icon-png-transparent-png.png"),
              ),
              ),
        
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                      Text(_items[index]["first_name"] + " " + _items[index]["last_name"], 
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                      ),
                      Text(_items[index]["username"],
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                      Text(_items[index].containsKey("status") ? _items[index]["status"] : " ")
                    ],
                  ),
                ],
            ),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:Column(
                    children:[
                      Text(
                        _items[index]["last_seen_time"]
                        ),
                        CircleAvatar(
                          radius: 15,
                          child: 
                          Text(
                            _items[index].containsKey("messages") ? _items[index]["messages"].toString() : "0"
                          ),
                        )
                        
                    ],
                  ),
                ),
              ]
          
         );

      
             },
            ),
          ) : Container()
        ]
       ),
      ),
/*floatingActionButton: FloatingActionButton(
onPressed: readJson,
tooltip: 'Increment',
child: Icon(Icons.add),
),*/// This trailing comma makes auto-formatting nicer for build methods.
  );
 }
}
