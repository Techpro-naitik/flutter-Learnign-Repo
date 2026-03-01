import 'package:flutter/material.dart';
import 'package:mini_project/components/floatingTabNavigationBar.dart';

import 'package:flutter_map/flutter_map.dart';




class Interventiondetails extends StatefulWidget {
  var id;
  Interventiondetails({Key? key, required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _Intervention();
}

class _Intervention extends State<Interventiondetails> {
  // int mainId = id;

  Widget build(BuildContext context) {
    print(widget.id['intervention']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Main Page ",
          style: TextStyle(color: const Color.fromARGB(255, 245, 243, 243)),
        ),
      ),
      body: Container(
        child: Center(child: Text('page:${widget.id['intervention']}')),
      ),
    );
  }
}
