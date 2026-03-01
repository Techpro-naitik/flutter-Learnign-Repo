import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mini_project/components/calculatorScreen.dart';
import 'package:mini_project/components/color_extenstion.dart';
import 'package:mini_project/components/indicator.dart';
import 'package:mini_project/components/interventionDetails.dart';
import 'package:mini_project/components/mapScreen.dart';
import 'package:mini_project/components/resources/app_colors.dart';
import 'package:mini_project/components/setting.dart';
import 'package:intl/intl.dart';
// import 'package:mini_project/main.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart_app/presentation/widgets/indicator.dart';
// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:fl_chart_app/indicator.dart';
// import 'package:flutter/material.dart';

Color _getLightColor(int index) {
  switch (index) {
    case 0:
      return Colors.amber.shade300;
    case 1:
      return Colors.cyan.shade300;
    case 2:
      return Colors.red.shade300;
    case 3:
      return Colors.blue.shade300;
    case 4:
      return Colors.lightGreen.shade300;
    default:
      return Colors.grey;
  }
}

Color _getDarkColor(int index) {
  switch (index) {
    case 0:
      return Colors.amber.shade800;
    case 1:
      return Colors.cyan.shade800;
    case 2:
      return Colors.red.shade800;
    case 3:
      return Colors.blue.shade800;
    case 4:
      return Colors.lightGreen.shade800;
    default:
      return Colors.grey.shade800;
  }
}

class Floatingtabnavigationbar extends StatefulWidget {
  final Color dark = AppColors.contentColorOrange;
  final Color normal = AppColors.contentColorGreen;
  final Color light = AppColors.contentColorCyan;

  final CameraDescription camera;

  const Floatingtabnavigationbar({key, required this.camera});

  @override
  State<Floatingtabnavigationbar> createState() => _Floatingtabnavigationbar();
}

class _Floatingtabnavigationbar extends State<Floatingtabnavigationbar> {
  int _selectedIndex = 0;
  int _SelectedTab = 0;
  int touchedIndex = -1;
  final barspace = 0;
  DateTime? _SelectedDate;
  final _url = Uri.parse("https://www.irctc.co.in/nget/");
  bool _visible = false;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  var imageCamera = '';
  // late CameraController _controller;
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,

      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text = switch (value.toInt()) {
      0 => 'Apr',
      1 => 'May',
      2 => 'Jun',
      3 => 'Jul',
      4 => 'Aug',
      _ => '',
    };
    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(fontSize: 10);
    return SideTitleWidget(
      meta: meta,
      child: Text(meta.formattedValue, style: style),
    );
  }

  void MainFunction() async {
    setState(() {
      _visible = !_visible;
    });
    print(_visible);
  }

  void CameaFunction() async {
    setState(() {
      _selectedIndex = 3;
    });
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await _controller.takePicture();

      /// 🔥 THIS is where setState goes
      setState(() {
        imageCamera = image.path;
        _visible = !_visible;
      });
      //  final imagePath = image.path;
      print("Start image");
      print(image);
      print("MID image");
      // print(imagePath);
      // imageCamera = imagePath;
      print("End image");
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      _url,
      mode: LaunchMode.inAppBrowserView,
      browserConfiguration: const BrowserConfiguration(showTitle: false),
    )) {
      throw Exception('Could not launch $_url');
    }
  }

  var Listdata = [
    {'id': 1, 'name': 'assets/images/intervention-details.png'},
    {'id': 2, 'name': 'assets/images/poster-1.png'},
    {'id': 3, 'name': 'assets/images/workshop-img.jpg'},
    {'id': 4, 'name': 'assets/images/coverage-upto.png'},
    {'id': 5, 'name': 'assets/images/banner.png'},
  ];

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    var barChartRodData = BarChartRodData(
      toY: 10,
      rodStackItems: [
        //BarChartRodStackItem(0, 1.5, widget.dark),
        //BarChartRodStackItem(1.5, 12, widget.normal),
        //BarChartRodStackItem(12, 14.5, widget.light),
      ],
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //// BarChartRodStackItem(0, 20, widget.dark),
              //BarChartRodStackItem(2, 12, widget.normal),
              //BarChartRodStackItem(12, 17, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 13, widget.dark),
              //// BarChartRodStackItem(13, 14, widget.normal),
              //BarChartRodStackItem(14, 24, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 6.5, widget.dark),
              //// BarChartRodStackItem(6.5, 18, widget.normal),
              //BarChartRodStackItem(18, 23.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 9, widget.dark),
              //BarChartRodStackItem(9, 15, widget.normal),
              //// BarChartRodStackItem(15, 29, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //// BarChartRodStackItem(0, 2.5, widget.dark),
              //BarChartRodStackItem(2.5, 17.5, widget.normal),
              //BarChartRodStackItem(17.5, 32, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 11, widget.dark),
              //BarChartRodStackItem(11, 18, widget.normal),
              //BarChartRodStackItem(18, 31, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 14, widget.dark),
              //BarChartRodStackItem(14, 27, widget.normal),
              //BarChartRodStackItem(27, 35, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 8, widget.dark),
              //BarChartRodStackItem(8, 24, widget.normal),
              //BarChartRodStackItem(24, 31, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 6.5, widget.dark),
              //BarChartRodStackItem(6.5, 12.5, widget.normal),
              //BarChartRodStackItem(12.5, 15, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 9, widget.dark),
              //BarChartRodStackItem(9, 15, widget.normal),
              //BarChartRodStackItem(15, 17, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 10, // rodStackItems: [
            //   //BarChartRodStackItem(0, 6, widget.dark),
            //   //BarChartRodStackItem(6, 23, widget.normal),
            //   //BarChartRodStackItem(23, 34, widget.light),
            // ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10, // rodStackItems: [
            //   //BarChartRodStackItem(0, 7, widget.dark),
            //   //BarChartRodStackItem(7, 24, widget.normal),
            //   //BarChartRodStackItem(24, 32, widget.light),
            // ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          barChartRodData,
          BarChartRodData(
            toY: 10, // rodStackItems: [
            //   //BarChartRodStackItem(0, 4, widget.dark),
            //   //BarChartRodStackItem(4, 15, widget.normal),
            //   //BarChartRodStackItem(15, 20, widget.light),
            // ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10, // rodStackItems: [
            //   //BarChartRodStackItem(0, 4, widget.dark),
            //   //BarChartRodStackItem(4, 15, widget.normal),
            //   //BarChartRodStackItem(15, 24, widget.light),
            // ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 9,
            rodStackItems: [
              //BarChartRodStackItem(0, 1.5, widget.dark),
              //BarChartRodStackItem(1.5, 12, widget.normal),
              //BarChartRodStackItem(12, 14, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 6,
            rodStackItems: [
              //BarChartRodStackItem(0, 7, widget.dark),
              //BarChartRodStackItem(7, 25, widget.normal),
              //BarChartRodStackItem(25, 27, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 10,
            rodStackItems: [
              //BarChartRodStackItem(0, 6, widget.dark),
              //BarChartRodStackItem(6, 23, widget.normal),
              //BarChartRodStackItem(23, 29, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 2,
            rodStackItems: [
              //BarChartRodStackItem(0, 9, widget.dark),
              //BarChartRodStackItem(9, 15, widget.normal),
              //BarChartRodStackItem(15, 16.5, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 4,
            rodStackItems: [
              //BarChartRodStackItem(0, 7, widget.dark),
              //BarChartRodStackItem(7, 12.5, widget.normal),
              //BarChartRodStackItem(12.5, 15, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }

  String getTabContent() {
    switch (_SelectedTab) {
      case 0:
        return "The Favourites section is designed to provide users with a personalized space where they can easily access the items, services, or content they value most. By saving preferred selections, users can streamline navigation, reduce search time, and enhance overall efficiency within the platform. This feature improves user engagement by allowing quick retrieval of frequently viewed or important items, ensuring a smoother and more convenient experience. Whether used for products, locations, articles, or services, the Favourites section helps maintain organization and accessibility. It reflects a user-centric design approach that prioritizes convenience, customization, and improved interaction with the system.";
      case 1:
        return "Business represents a structured and strategic approach to delivering products or services that create value for customers while ensuring sustainable growth and profitability. It involves careful planning, market analysis, financial management, and operational efficiency to achieve long-term objectives. A successful business focuses on innovation, quality assurance, customer satisfaction, and continuous improvement to stay competitive in an evolving marketplace. Strong leadership, ethical practices, and a results-driven mindset are essential components that drive performance and build brand reputation. By fostering meaningful client relationships and adapting to industry trends, a business can expand its reach, optimize resources, and achieve measurable success across diverse markets.";
      case 2:
        return "The Cabin Crew plays a vital role in ensuring passenger safety, comfort, and overall in-flight experience. As frontline representatives of the airline, cabin crew members are trained to handle emergency procedures, safety demonstrations, and compliance protocols with professionalism and precision. Beyond safety responsibilities, they deliver exceptional customer service by assisting passengers, addressing concerns, and maintaining a welcoming environment throughout the journey. Strong communication skills, cultural awareness, teamwork, and the ability to remain calm under pressure are essential qualities in this profession. By combining hospitality with operational discipline, cabin crew professionals contribute significantly to building passenger trust, airline reputation, and a seamless travel experience.";
      case 3:
        return "The Copy File feature enables users to create an exact duplicate of an existing file without altering the original content. This functionality is essential for maintaining data integrity while allowing modifications, backups, or distribution of information as needed. By generating a separate copy, users can safely edit or share files without the risk of losing important data. The feature supports organized file management by allowing the duplicated file to be stored in a selected destination folder, ensuring easy access and systematic arrangement. Widely used in professional, educational, and operational environments, the Copy File function enhances productivity, prevents accidental data loss, and promotes efficient workflow management across digital platforms.";
      case 4:
        return "The Map feature is designed to provide users with a comprehensive and interactive way to explore locations, navigate routes, and access important geographic information in real time. It enables accurate positioning through advanced location services, allowing users to identify their current location, search for destinations, and receive step-by-step directions with clarity and precision. The map interface supports route optimization, nearby place discovery, and distance calculation to enhance overall usability and efficiency. Whether used for travel, business operations, service tracking, or personal navigation, this feature ensures reliability, convenience, and improved decision-making. With smooth zooming, marker placement, and real-time updates, the map system enhances the overall user experience by delivering clear visual guidance and dependable location data.";

      default:
        return "null";
    }
  }

  // List<PieChartSectionData> showingSections() {
  //   return List.generate(5, (i) {
  //     final isTouched = i == touchedIndex;
  //     final fontSize = isTouched ? 25.0 : 16.0;
  //     final radius = isTouched ? 90.0 : 50.0;
  //     const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
  //     return switch (i) {
  //       0 => PieChartSectionData(
  //         color: Colors.amber,
  //         value: 40,
  //         title: '40%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: const Color.fromARGB(255, 9, 8, 4),
  //           shadows: shadows,
  //         ),
  //       ),
  //       1 => PieChartSectionData(
  //         color: const Color.fromARGB(255, 7, 218, 255),
  //         value: 30,
  //         title: '30%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: const Color.fromARGB(255, 7, 255, 7),
  //           shadows: shadows,
  //         ),
  //       ),
  //       2 => PieChartSectionData(
  //         color: const Color.fromARGB(255, 255, 7, 7),
  //         value: 15,
  //         title: '15%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: const Color.fromARGB(255, 7, 255, 127),
  //           shadows: shadows,
  //         ),
  //       ),
  //       3 => PieChartSectionData(
  //         color: const Color.fromARGB(255, 7, 77, 255),
  //         value: 15,
  //         title: '15%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: const Color.fromARGB(255, 239, 52, 5),
  //           shadows: shadows,
  //         ),
  //       ),
  //        4 => PieChartSectionData(
  //         color: const Color.fromARGB(255, 132, 237, 3),
  //         value: 15,
  //         title: '15%',
  //         radius: radius,
  //         titleStyle: TextStyle(
  //           fontSize: fontSize,
  //           fontWeight: FontWeight.bold,
  //           color: const Color.fromARGB(255, 239, 52, 5),
  //           shadows: shadows,
  //         ),
  //       ),
  //       _ => throw StateError('Invalid'),
  //     };
  //   });
  // }
  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 14.0;
      final radius = isTouched ? 95.0 : 70.0;

      return PieChartSectionData(
        value: [40.0, 30.0, 15.0, 15.0, 15.0][i],
        title: ['40%', '30%', '15%', '15%', '15%'][i],
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
        ),

        // 🎨 Gradient for 3D effect
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_getLightColor(i), _getDarkColor(i)],
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,

        leading: Icon(Icons.arrow_back, color: Colors.white),
        elevation: 10,
        // shape:ShapeBorder.lerp(a, b, t)
        title: Text("Dashboard", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Setting(camera: widget.camera),
                ),
              );
            },
            icon: Icon(Icons.settings, color: Colors.white),
            style: ButtonStyle(),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 30,
        onPressed: () {
          print('$_visible');
          print('$_selectedIndex');
          setState(() {
            _selectedIndex = 3;
          });
        },
        shape: const CircleBorder(),
        child: _selectedIndex == 3 && _visible == false
            ? IconButton(
                onPressed: () {},
                onLongPress: CameaFunction,
                icon: Icon(Icons.camera),
              )
            : Icon(Icons.camera_alt, size: 30),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // creates notch
        notchMargin: 12,
        child: Container(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  print("Home Button Pressed");
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.home,

                  color: _selectedIndex == 0
                      ? const Color.fromARGB(255, 115, 30, 201)
                      : const Color.fromARGB(255, 44, 37, 52),
                ),
              ),
              IconButton(
                onPressed: () {
                  print("Description Button Is Pressed");
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.description,
                  color: _selectedIndex == 1
                      ? const Color.fromARGB(255, 115, 30, 201)
                      : const Color.fromARGB(255, 44, 37, 52),
                ),
              ),

              SizedBox(width: 40),
              IconButton(
                onPressed: () {
                  print("People Button Pressed");
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: _selectedIndex == 2
                      ? const Color.fromARGB(255, 115, 30, 201)
                      : const Color.fromARGB(255, 44, 37, 52),
                ),
              ),
              IconButton(
                onPressed: () {
                  print("People Button Pressed");
                  setState(() {
                    _selectedIndex = 4;
                  });
                },
                icon: Icon(
                  Icons.people,
                  color: _selectedIndex == 4
                      ? const Color.fromARGB(255, 115, 30, 201)
                      : const Color.fromARGB(255, 44, 37, 52),
                ),
              ),

              // /// Right Icons
              // Icon(Icons.description, color: Colors.deepPurple),
              // Icon(Icons.people, color: Colors.deepPurple),
            ],
          ),
        ),
      ),

      body: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 155,
                child: CarouselSlider(
                  options: CarouselOptions(height: 200, autoPlay: true),
                  items: Listdata.map((ele) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          // height: 300,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 9.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(0, 7, 172, 255),
                            image: DecorationImage(
                              image: AssetImage("${ele['name']}"),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      "Interventions",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Icon(Icons.arrow_right),
                ],
              ),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 70,

                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          border: Border(top: BorderSide.none),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  var obj = {'intervention': 'One'};
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_context) =>
                                          Interventiondetails(id: obj),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: SvgPicture.asset(
                                    height: 50,
                                    "assets/images/authenticity.svg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text("Intervention"),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        height: 70,

                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  var obj = {'intervention': 'Second'};
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_context) =>
                                          Interventiondetails(id: obj),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  child: SvgPicture.asset(
                                    height: 50,
                                    "assets/images/technology-upgradation.svg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Text("Intervention"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 70,

                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  var obj = {'intervention': "Third"};
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          Interventiondetails(id: obj),
                                    ),
                                  );
                                },
                                child: ClipRect(
                                  child: SvgPicture.asset(
                                    height: 50,
                                    "assets/images/trainings.svg",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              Text("Intervention"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                        // borderRadius: BorderRadius.circular(20),
                        border: Border(top: BorderSide.none),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              var obj = {'intervention': "Fourth"};
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Interventiondetails(id: obj),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SvgPicture.asset(
                                "assets/images/capacity-building-training.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text("Intervention"),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: 70,

                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              var obj = {'intervention': "Five"};
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Interventiondetails(id: obj),
                                ),
                              );
                            },
                            child: ClipRRect(
                              child: SvgPicture.asset(
                                // height: 10,
                                "assets/images/sme-exchange-program.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text("Intervention"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 70,

                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              var obj = {"intervention": "Six"};
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Interventiondetails(id: obj),
                                ),
                              );
                            },
                            child: ClipRect(
                              child: SvgPicture.asset(
                                //  height: 10,
                                "assets/images/workshop.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text("Intervention"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70,
                      margin: EdgeInsets.all(5),

                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                        border: Border(top: BorderSide.none),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              var obj = {"intervention": "Seven"};
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Interventiondetails(id: obj),
                                ),
                              );
                            },
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: SvgPicture.asset(
                                height: 40,
                                "assets/images/intervention.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text("Intervention"),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: 70,

                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              var obj = {"intervention": "Eight"};
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Calculatorscreen(),)
                              );
                            },
                            child: ClipRRect(
                              child: SvgPicture.asset(
                                // height: 10,
                                "assets/images/ecgc-reimbursement.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text("Calculator"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 70,

                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              var obj = {"intervention": "Nine"};
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MapScreen(),
                                ),
                              );
                            },
                            child: ClipRect(
                              child: SvgPicture.asset(
                                //  height: 10,
                                "assets/images/knowlege-repo.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text("Maps"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _SelectedTab = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _SelectedTab == 0
                              ? Colors.deepPurple
                              : Colors.white,
                          foregroundColor: _SelectedTab == 0
                              ? Colors.white
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite_border_rounded,
                              color: _SelectedTab == 0
                                  ? Colors.white
                                  : Colors.deepPurple,
                            ),
                            Text("Favourites"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _SelectedTab = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _SelectedTab == 1
                              ? Colors.deepPurple
                              : Colors.white,
                          foregroundColor: _SelectedTab == 1
                              ? Colors.white
                              : null,
                          shape: RoundedSuperellipseBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.business,
                              color: _SelectedTab == 1
                                  ? const Color.fromARGB(255, 223, 222, 224)
                                  : Colors.deepPurple,
                            ),
                            Text("Bussiness"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _SelectedTab = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _SelectedTab == 2
                              ? Colors.deepPurple
                              : Colors.white,
                          foregroundColor: _SelectedTab == 2
                              ? Colors.white
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        child: Column(
                          children: [
                            Icon(
                              Icons.cabin_outlined,
                              color: _SelectedTab == 2
                                  ? const Color.fromARGB(255, 237, 236, 239)
                                  : Colors.deepPurple,
                            ),
                            Text("Cabin Crew"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),

                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _SelectedTab = 3;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _SelectedTab == 3
                              ? Colors.deepPurple
                              : Colors.white,
                          foregroundColor: _SelectedTab == 3
                              ? Colors.white
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.file_copy,
                              color: _SelectedTab == 3
                                  ? const Color.fromARGB(255, 240, 237, 246)
                                  : Colors.deepPurple,
                            ),
                            Text("Copy File"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(12),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _SelectedTab = 4;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _SelectedTab == 4
                              ? Colors.deepPurple
                              : Colors.white,
                          foregroundColor: _SelectedTab == 4
                              ? Colors.white
                              : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.add_location_alt_outlined,
                              color: _SelectedTab == 4
                                  ? const Color.fromARGB(255, 245, 244, 247)
                                  : Colors.deepPurple,
                            ),
                            Text("Map"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // height: 70,
                child: Center(
                  // child: SingleChildScrollView(
                  // scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 10,
                        shadowColor: Color.fromARGB(255, 177, 6, 220),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: AlignmentGeometry.topLeft,
                                      child: Text(
                                        _SelectedTab == 0
                                            ? 'Favourites:'
                                            : _SelectedTab == 1
                                            ? 'Bussiness:'
                                            : _SelectedTab == 2
                                            ? 'Cabin Crew:'
                                            : _SelectedTab == 3
                                            ? 'Copy File:'
                                            : _SelectedTab == 4
                                            ? 'Map:'
                                            : '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(getTabContent(), maxLines: 1),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () {
                                    // print("Hi");
                                    showDialog(
                                      useSafeArea: true,

                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 50,
                                          child: Dialog(
                                            // insetAnimationCurve:
                                            //     Curves.decelerate,
                                            insetPadding: EdgeInsets.all(20),
                                            child: SizedBox(
                                              // height: 20,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Card(
                                                    margin: EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentGeometry
                                                                  .topLeft,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                            icon: Icon(
                                                              Icons.cancel,
                                                            ),
                                                          ),
                                                        ),
                                                        Title(
                                                          color: Colors.black,
                                                          child: Text(
                                                            _SelectedTab == 0
                                                                ? 'Favourites'
                                                                : _SelectedTab ==
                                                                      1
                                                                ? 'Bussiness'
                                                                : _SelectedTab ==
                                                                      2
                                                                ? 'Cabin Crew'
                                                                : _SelectedTab ==
                                                                      3
                                                                ? 'Copy File'
                                                                : _SelectedTab ==
                                                                      4
                                                                ? 'Map'
                                                                : '',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                8.0,
                                                              ),

                                                          child: Text(
                                                            getTabContent(),
                                                            style: TextStyle(
                                                              wordSpacing: 4,
                                                            ),
                                                          ),
                                                        ),

                                                        // height: 40,
                                                        // color: Colors.amber,
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Row()
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text("More"),
                                  style: ButtonStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ),
            ],
          ),
        ),

        Container(
          height: 70,
          width: 800,
          child: Center(
            child: TextButton(onPressed: _launchUrl, child: Text("Open URL")),
          ),
        ),
        Container(
          child: Center(
            child: TextButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  // barrierColor: Colors.deepPurple,
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2090),
                );
                setState(() {
                  _SelectedDate = pickedDate;
                });
              },
              child: Text(
                "Select Date = ${_SelectedDate == null ? 'Not Selected Date' : DateFormat('dd-MM-yyyy').format(_SelectedDate!)}",
              ),
            ),
          ),

          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 227, 227, 228),
          ),
        ),
        Container(
          child: _visible == false
              ? FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    CircularProgressIndicator();
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            /// ✅ Camera Preview
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: SizedBox(
                                  height: 400,
                                  width: 480,
                                  child: CameraPreview(_controller),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Center(
                  child: Container(
                    height: 900,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 2,
                              // style :BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignCenter,
                            ),
                          ),
                          child: Image.file(
                            File(imageCamera!),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              autofocus: true,
                              onPressed: CameaFunction,
                              style: ButtonStyle(
                                elevation: WidgetStateProperty.all(100),
                                backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 133, 5, 230),
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              child: Text("Cancel"),
                            ),
                            TextButton(onPressed: () {}, child: Text("Submit")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        SingleChildScrollView(
          child: Container(
            // height: 70,
            // width: 800,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    const SizedBox(height: 18),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!
                                          .touchedSectionIndex;
                                    });
                                  },
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(),
                          ),
                        ),
                        // child: PieChart(
                        //   PieChartData(
                        //     sectionsSpace: 3,
                        //     centerSpaceRadius: 50,
                        //     sections: showingSections(),
                        //   ),
                        // ),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Indicator(
                          color: AppColors.contentColorBlue,
                          text: 'First',
                          isSquare: true,
                        ),
                        SizedBox(height: 4),
                        Indicator(
                          color: AppColors.contentColorYellow,
                          text: 'Second',
                          isSquare: true,
                        ),
                        SizedBox(height: 4),
                        Indicator(
                          color: Color.fromARGB(255, 255, 14, 14),
                          text: 'Third',
                          isSquare: true,
                        ),
                        SizedBox(height: 4),
                        Indicator(
                          color: Color.fromARGB(255, 3, 26, 236),
                          text: 'Fourth',
                          isSquare: true,
                        ),
                        Indicator(
                          color: AppColors.contentColorGreen,
                          text: 'Fifth',
                          isSquare: true,
                        ),
                        SizedBox(height: 18),
                      ],
                    ),
                    const SizedBox(width: 28),
                  ],
                ),
                AspectRatio(
                  aspectRatio: 1.66,
                  child: LayoutBuilder(
                    builder: (context, Constraints) {
                      var barspace = 4.4 * Constraints.maxWidth / 400;
                      barspace = barspace;
                      final barsWidth = 8.0 * Constraints.maxWidth / 400;
                      return BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.center,
                          barTouchData: const BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                getTitlesWidget: bottomTitles,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: leftTitles,
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            checkToShowHorizontalLine: (value) =>
                                value % 10 == 0,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: AppColors.borderColor.withValues(
                                alpha: 0.1,
                              ),
                              strokeWidth: 1,
                            ),
                            drawVerticalLine: false,
                          ),
                          borderData: FlBorderData(show: false),
                          groupsSpace: barspace,
                          barGroups: getData(barsWidth, barspace),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ][_selectedIndex],
    );
  }
}
