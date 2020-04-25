import 'package:flutter/material.dart';
import 'package:tictacgame/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: mainScreen(),
      ),
    ),
  );
}

class mainScreen extends StatefulWidget {
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(
        seconds: 2,
      ),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicTacGame(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 250.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png'),
              Text(
                'Tic-Tac',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  letterSpacing: 9.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The Game',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
