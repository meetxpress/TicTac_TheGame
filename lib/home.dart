import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('TicTac-The Game'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: TicTacGame(),
      ),
    ),
  );
}

class TicTacGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TicTacGameState();
  }
}

class _TicTacGameState extends State<TicTacGame> {
  List<List> _matrix;
  _TicTacGameState() {
    _initMatrix();
  }
  int xw = 0;
  int ow = 0;
  _initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: <Widget>[
                    Text(
                      'X: $xw\t\t\t\t\t\t\t\t O: $ow',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(0, 0),
                _buildElement(0, 1),
                _buildElement(0, 2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(1, 0),
                _buildElement(1, 1),
                _buildElement(1, 2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildElement(2, 0),
                _buildElement(2, 1),
                _buildElement(2, 2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 80.0, 0, 0),
                  child: FlatButton(
                    child: Text(
                      'Reset Game',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.white,
                        backgroundColor: Colors.white10,
                      ),
                    ),
                    onPressed: () {
                      setState(
                            () {
                          _initMatrix();
                          ow = 0;
                          xw = 0;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _lastChar = 'o';

  _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);

        if (_checkWinner(i, j)) {
          _showDialog(_matrix[i][j]);
        } else {
          if (_checkDraw()) {
            _showDialog(null);
          }
        }
      },
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //border: Border.all(color: Colors.black),
          border: Border(
            top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
            left: BorderSide(width: 0.0, color: Color(0xFFFFFFFFFF)),
            right: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
            bottom: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
          ),
        ),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(fontSize: 92.0),
          ),
        ),
      ),
    );
  }

  _changeMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (_lastChar == 'O') {
          _matrix[i][j] = 'X';
        } else {
          _matrix[i][j] = 'O';
        }
        _lastChar = _matrix[i][j];
      }
    });
  }

  _checkDraw() {
    var draw = true;
    _matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ') {
          draw = false;
        }
      });
    });
    return draw;
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) {
        col++;
      }
      if (_matrix[i][y] == player) {
        row++;
      }
      if (_matrix[i][i] == player) {
        diag++;
      }
      if (_matrix[i][n - i] == player) {
        rdiag++;
      }
    }
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      return true;
    }
    return false;
  }

  _showDialog(String winner) {
    String dialogText;
    if (winner == null) {
      dialogText = 'It\'s a draw';
    } else {
      dialogText = 'Player \'$winner\' won. Next turn will be of another player.';
      if ('$winner' == 'X') {
        xw++;
      } else {
        ow++;
      }
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Game over'),
            content: Text(dialogText),
            actions: <Widget>[
              FlatButton(
                child: Text('Reset Game'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _initMatrix();
                  });
                },
              )
            ],
          );
        });
  }
}
