import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorScreen();
}

class _CalculatorScreen extends State<StatefulWidget> {
  final TextEditingController _calculateController = TextEditingController();
  final TextEditingController _calculateController_B = TextEditingController();
  TextEditingController _Sum = TextEditingController();
  TextEditingController _Mult = TextEditingController();
  TextEditingController _Divide = TextEditingController();
  TextEditingController _Sub = TextEditingController();
  final FocusNode _focusA = FocusNode();
  final FocusNode _focusB = FocusNode();

  @override
  void dispose() {
    print('CurrentText=======>$_calculateController');
    _calculateController.dispose();
    _calculateController_B.dispose();
    super.dispose();
  }

  void addValue(String value) {
    print('CheckingFocunsCalling==>$_focusA');
    print('CheckingFocusCalling===>$_focusB');
    setState(() {
      if (_focusA.hasFocus) {
        _calculateController.text += value;
      } else if (_focusB.hasFocus) {
        _calculateController_B.text += value;
      }
    });
  }

  void add() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Calculator"),
      ),
      body: Container(
        width: 1100,

        child: Card(
          color: const Color.fromARGB(255, 7, 178, 240),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 234, 235),
                ),

                margin: EdgeInsets.all(6),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: _focusA,
                        readOnly: true,
                        controller: _calculateController,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'[,\-\.]')),
                        ],
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,

                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),

                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          labelText: "Please Enter A",
                          hintText: "Enter value",
                          counterText: "",
                          border: OutlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),

                        onChanged: (value) {
                          print("Typing: $value");
                          setState(() {
                            // _calculateController.text += "";
                          });
                        },

                        onSubmitted: (value) {
                          print("Submitted: $value");
                        },
                      ),
                    ),
                    // Center(child: Expanded(child: Text("X,+,/,-"))),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        focusNode: _focusB,
                        readOnly: true,
                        controller: _calculateController_B,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'[,\-\.]')),
                        ],
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,

                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),

                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          labelText: "Please Enter B",
                          hintText: "Enter value",
                          counterText: "",
                          border: OutlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),

                        onChanged: (value) {
                          print("Typing: $value");
                          _calculateController_B.text += value;
                        },
                        onSubmitted: (value) {
                          print("Submitted: $value");
                        },
                      ),
                    ),

                    // Center(child: Expanded(child: Text("="))),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 234, 235),
                ),

                margin: EdgeInsets.all(6),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _Sum,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'[,\-\.]')),
                        ],
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),

                          labelText: "SUM",
                          hintText: "Enter value",
                          counterText: "",
                          border: OutlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),

                        onChanged: (value) {
                          print("Typing: $value");
                        },

                        onSubmitted: (value) {
                          print("Submitted: $value");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 234, 235),
                ),

                margin: EdgeInsets.all(6),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _Mult,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'[,\-\.]')),
                        ],
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          labelText: "Multiply",
                          hintText: "Enter value",
                          counterText: "",
                          border: OutlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),

                        onChanged: (value) {
                          print("Typing: $value");
                        },

                        onSubmitted: (value) {
                          print("Submitted: $value");
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 234, 235),
                ),

                margin: EdgeInsets.all(6),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _Divide,

                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'[,\-\.]')),
                        ],
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          labelText: "Devide",
                          hintText: "Enter value",
                          counterText: "",
                          border: OutlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),

                        onChanged: (value) {
                          print("Typing: $value");
                        },

                        onSubmitted: (value) {
                          print("Submitted: $value");
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 234, 235),
                ),

                margin: EdgeInsets.all(6),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _Sub,
                        inputFormatters: [
                          // FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.deny(RegExp(r'[,\-\.]')),
                        ],
                        textDirection: TextDirection.rtl,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          labelText: "Subtract",
                          hintText: "Enter value",
                          counterText: "",
                          border: OutlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),

                        onChanged: (value) {
                          print("Typing: $value");
                        },

                        onSubmitted: (value) {
                          print("Submitted: $value");
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Wrap(
                    spacing: 50,
                    runSpacing: 30,
                    children: [
                      for (var i = 1; i <= 9; i++)
                        ElevatedButton(
                          onPressed: () {
                            addValue(i.toString());
                          },
                          child: Text(i.toString()),
                        ),
                      ElevatedButton(onPressed: () {}, child: Text("")),
                      ElevatedButton(onPressed: () {}, child: Text('0')),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _calculateController.clear();
                            _calculateController_B.clear();
                            _Sum.clear();
                            _Mult.clear();
                            _Divide.clear();
                            _Sub.clear();
                          });
                        },
                        child: Text("Ac"),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 30),
                        ),
                        // style: ButtonStyle(
                        //   maximumSize: WidgetStatePropertyAll(Size(0,0)),
                        // ),
                        onPressed: () {
                          // addValue('+');
                          final a =
                              int.tryParse(_calculateController.text) ?? 0;
                          final b =
                              int.tryParse(_calculateController_B.text) ?? 0;
                          setState(() {
                            _Sum.text = (a + b).toString();
                            _Divide.text = (a / b).toString();
                            _Mult.text = (a * b).toString();
                            _Sub.text = (a - b).toString();
                          });
                        },
                        child: Text("Result"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
