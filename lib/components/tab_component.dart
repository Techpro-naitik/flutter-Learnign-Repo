import 'package:flutter/material.dart';


class TabComponent extends StatefulWidget {
  const TabComponent({Key});
  @override
  State<TabComponent> createState() => _TabComponent();
}

class _TabComponent extends State<TabComponent> {
  int _selectedIndex = 0;
  bool _showNotch = true;
  void selected(index) {
    setState(() {
      _selectedIndex = index;
    });
    print(_selectedIndex);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title:Text("Dashboard"),
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.logout_outlined)),
           IconButton(onPressed: (){

          }, icon: Icon(Icons.logout_outlined)),
          
        ]
        ),
      
      body: [
        Container(
          child: ListView(
      
            children: [
              Card(
                child: Container(
                  height:100,
                  width: 1,
                  // widthFactor: 1.1,
                  //  heightFactor: 0.1,
            
                ),
              ),
              Card(
                child: Center(   
                  //  widthFactor: 1.1,
                  // heightFactor: 0.1,
                  // child: Image.asset('/images/image1.jpg'),
                ),
              ),
              Card(
                child: Center(
                  //  widthFactor: 1.1,
                  //   heightFactor: 0.1,
                  // child: Image.asset('/images/image1.jpg'),
                ),
              ),
              Card(
                child: Center(
                  //  widthFactor: 1.1,
                  //    heightFactor: 0.1,
                  // child: Image.asset('/images/image1.jpg'),
                ),
              ),
            ],
          ),
        ),
        ListView(
          children: [
            Card(
              child: ListTile(
                leading: Text("1"),
                title: Text("Second Tab"),
                trailing: Icon(Icons.add),
              ),
            ),
          ],
        ),
        ListView(
          children: [
            Card(
              child: ListTile(
                leading: Text("1"),
                title: Text("Third"),
                trailing: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
        
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Tab1"),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_front),
            label: "Tab2",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Tab3"),
        ],
        

        onTap: selected,
        currentIndex: _selectedIndex,
      ),
      

    );
  }
}
