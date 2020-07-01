import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SleepPage extends StatelessWidget {
  List times;

  SleepPage({Key key, this.times}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Times'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: <Widget>[
                Center(
                    child: Text(
                        'You should to fall asleep at one of the following times:',
                      style: TextStyle(fontSize: 20), textAlign: TextAlign.center,
                    ),

                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(times[5] +
                        ' or ' +
                        times[4] +
                        ' or ' +
                        times[3] +
                        ' or ' +
                        times[2] +
                        ' or ' +
                        times[1] +
                        ' or ' +
                        times[0],
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
