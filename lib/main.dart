import 'dart:ui';

import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';
import "./calculator.dart";

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Calc calc = Calc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            calc.operation,
                            style:
                                TextStyle(fontSize: 30, color: Colors.white38),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            calc.placeHolder,
                            style: TextStyle(fontSize: 60, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            flex: 7,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: createButton(
                          ["AC", "+/-", "%", "÷"],
                          Colors.black,
                          [
                            () {
                              setState(() {
                                calc.reset();
                              });
                            },
                            () {
                              setState(() {
                                calc.reverse();
                              });
                            },
                            () {
                              setState(() {
                                calc.funcPress("%");
                              });
                            },
                            () {
                              setState(() {
                                calc.funcPress("÷");
                              });
                            }
                          ],
                          colors: [
                            Colors.grey[500],
                            Colors.grey[500],
                            Colors.grey[500],
                            Colors.orange
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: createButton(
                          [7, 8, 9, "X"],
                          Colors.white,
                          [
                            () {
                              setState(() {
                                calc.numPress(7);
                              });
                            },
                            () {
                              setState(() {
                                calc.numPress(8);
                              });
                            },
                            () {
                              setState(() {
                                calc.numPress(9);
                              });
                            },
                            () {
                              setState(() {
                                calc.funcPress("x");
                              });
                            }
                          ],
                          btnColor: Colors.grey[800]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: createButton(
                          [4, 5, 6, "-"],
                          Colors.white,
                          [
                            () {
                              setState(() {
                                calc.numPress(4);
                              });
                            },
                            () {
                              setState(() {
                                calc.numPress(5);
                              });
                            },
                            () {
                              setState(() {
                                calc.numPress(6);
                              });
                            },
                            () {
                              setState(() {
                                calc.funcPress("-");
                              });
                            }
                          ],
                          btnColor: Colors.grey[800]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: createButton(
                          [1, 2, 3, "+"],
                          Colors.white,
                          [
                            () {
                              setState(() {
                                calc.numPress(1);
                              });
                            },
                            () {
                              setState(() {
                                calc.numPress(2);
                              });
                            },
                            () {
                              setState(() {
                                calc.numPress(3);
                              });
                            },
                            () {
                              setState(() {
                                calc.funcPress("+");
                              });
                            }
                          ],
                          btnColor: Colors.grey[800]),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: createButton(
                            [0, ",", "=", "DEV"],
                            Colors.white,
                            [
                              () {
                                setState(() {
                                  calc.numPress(0);
                                });
                              },
                              () {
                                setState(() {
                                  calc.decimal();
                                });
                              },
                              () {
                                setState(() {
                                  calc.equals();
                                });
                              },
                              () {
                                launchURL();
                              }
                            ],
                            btnColor: Colors.grey[800]))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

launchURL() async {
  const url = 'https://ertugrulyakin.engineer';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

createButton(btnText, Color textColor, onPressed,
    {int btnNum = 4, colors, Color btnColor}) {
  List<Widget> list = new List();

  for (var i = 0; i < btnNum; i++) {
    var w = Padding(
        padding: EdgeInsets.fromLTRB(4, 15, 4, 4),
        child: ClipOval(
          child: InkWell(
            child: MaterialButton(
              onPressed: onPressed[i],
              color: () {
                if (colors != null)
                  return colors[i];
                else if (i == 3)
                  return Colors.orange[700];
                else
                  return btnColor;
              }(),
              padding: EdgeInsets.all(20),
              shape: CircleBorder(),
              highlightColor: Colors.blue,
              child: Text(
                btnText[i].toString(),
                style: TextStyle(
                    fontSize: 25, color: i == 3 ? Colors.white : textColor),
              ),
            ),
          ),
        ));
    list.add(w);
  }

  return list;
}
