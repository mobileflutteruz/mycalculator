import 'package:calculator/screens/my_button.dart';
import 'package:calculator/screens/size_config.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = "";
  var userAnswer = "";

  final List<String> button = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          userQuestion,
                          style: TextStyle(color: Colors.white, fontSize: 33),
                        )),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          userAnswer,
                          style: TextStyle(color: Colors.white, fontSize: 33),
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: button.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                          buttonTopped: () {
                            setState(
                              () {
                                userQuestion = "";
                              },
                            );
                          },
                          buttonText: button[index],
                          color: Colors.green,
                          textcolor: Colors.white,
                        );
                      } else if (index == 1) {
                        return MyButton(
                          buttonTopped: () {
                            setState(
                              () {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              },
                            );
                          },
                          buttonText: button[index],
                          color: Colors.red,
                          textcolor: Colors.white,
                        );
                      }

                      // equal button
                      else if (index == button.length - 1) {
                        return MyButton(
                          buttonTopped: () {
                            setState(
                              () {
                                equalPressed();
                              },
                            );
                          },
                          buttonText: button[index],
                          color: Colors.grey.shade900,
                          textcolor: Colors.white,
                        );
                      } else {
                        return MyButton(
                          buttonTopped: () {
                            setState(() {
                              userQuestion += button[index];
                            });
                          },
                          buttonText: button[index],
                          color: isOperastor(button[index])
                              ? Colors.grey.shade900
                              : Colors.grey.shade600,
                          textcolor: isOperastor(button[index])
                              ? Colors.white
                              : Colors.grey.shade900,
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperastor(String x) {
    if (x == "x" || x == "/" || x == "-" || x == "+" || x == "=") {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("x", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
