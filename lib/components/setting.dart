// import 'package:camera/camera.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mini_project/components/floatingTabNavigationBar.dart';


// class Setting extends StatefulWidget {
//   final CameraDescription camera;   // ✅ Add this

//       const Setting({key ,required this.camera});

//   @override
//   State<StatefulWidget> createState() => _SettingButton();
// }

// class _SettingButton extends State<StatefulWidget> {
//   int _selected = 0;
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => Floatingtabnavigationbar(
//                 camera: widget.,   
//                 )),
//             );
//           },
//           icon: Icon(Icons.arrow_back),
//         ),
//         title: Text("Setting Page"),
//       ),
//       body: Center(
//         child: Container(
//           child: TextButton(
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return Dialog(
//                     // shape:Border(right: BorderSide.none,left: BorderSide.none)

//                     // backgroundColor:const Color.fromARGB(255, 203, 177, 248),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(22),

//                               color: Colors.deepPurple,
//                             ),

//                             margin: EdgeInsets.all(10),
//                             child: Row(
//                               children: [
//                                 IconButton(
//                                   color: Colors.white,
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   icon: Icon(Icons.cancel_outlined),
//                                 ),
//                                 SizedBox(width: 60),

//                                 Text(
//                                   "Open Dialog Box",
//                                   style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 150,
//                             child: CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 100,
//                                 autoPlay: true,
//                               ),
//                               items: [1, 2, 3, 4, 5].map((res) {
//                                 return Builder(
//                                   builder: (BuildContext content) {
//                                     return Container(
//                                       child: Image.asset(
//                                         "assets/images/banner.png",
//                                       ),
//                                     );
//                                   },
//                                 );
//                               }).toList(),
//                             ),
//                           ),

//                           Column(
//                             //     margin: EdgeInsets.only(left: 5,right: 5, bottom: 20),

//                             // height: 409,
//                             children: [
//                               SizedBox(
//                                 height: 400,
//                                 child: Card(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     // child:
//                                     child: ListView(
//                                       children: [
//                                         Text("Main Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                                         Text(
//                                           "Where does it come from? Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text("close"),
//                                 style: ButtonStyle(
//                                   backgroundColor: WidgetStatePropertyAll(
//                                     Colors.deepPurple,
//                                   ),
//                                   foregroundColor: WidgetStatePropertyAll(
//                                     Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//             child: Text("Open Dialog", style: TextStyle()),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'floatingTabNavigationBar.dart';

class Setting extends StatefulWidget {
  final CameraDescription camera;

  const Setting({super.key, required this.camera});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting Page"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Floatingtabnavigationbar(
                  camera: widget.camera, // ✅ correct usage
                ),
              ),
            );
          },
        ),
      ),
      body: const Center(
        child: Text(
          "Settings Screen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}