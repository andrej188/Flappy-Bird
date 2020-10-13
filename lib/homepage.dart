import 'dart:async';
import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.5;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted  = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
      });

      setState(() {
        if(barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.05;
        }
      });

      setState(() {
        if(barrierXTwo < -2) {
          barrierXTwo += 3.5;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if(birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: <Widget>[
                      AnimatedContainer(
                        alignment: Alignment(0, birdYAxis),
                        duration: Duration(microseconds: 0),
                        color: Colors.blueAccent,
                        child: MyBird(),
                      ),
                      Container(
                        alignment: Alignment(0, -0.4),
                        child: (gameHasStarted) ? Text('') : Text('T A P  T O  P L A Y', style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Bold')),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXOne,1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 200.0,
                        ),
                      ),

                      AnimatedContainer(
                        alignment: Alignment(barrierXOne,-1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 200.0,
                        ),
                      ),

                      AnimatedContainer(
                        alignment: Alignment(barrierXTwo, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 150.0,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barrierXTwo,-1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(
                          size: 250.0,
                        ),
                      ),
                    ],
                  ),
                  ),
              Container(
                height: 15,
                color: Colors.green,
              ),
              Expanded(
                  child: Container(
                      color: Colors.brown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Score', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Bold')),
                              SizedBox(height: 5),
                              Text('0', style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'Bold')),
                            ],
                          ),
                          // Padding(padding: EdgeInsets.all(5)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Best Score', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Bold')),
                              SizedBox(height: 10),
                              Text('10', style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'Bold')),
                            ],
                          )
                        ],
                      ),
                  )
              ),
            ],
          ),
        ),
    );
  }
}
