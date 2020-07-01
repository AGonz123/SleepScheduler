import 'package:flutter/material.dart';

class WakeUpPage extends StatelessWidget {
  List times;
  WakeUpPage({Key key, this.times}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wake Up times'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'It takes the average human fourteen minutes to fall asleep.',
                    style: TextStyle(fontSize: 20), textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'If you head to bed right now, you should try to wake up at one of the following times:',
                    style: TextStyle(fontSize: 20), textAlign: TextAlign.center,
                  ),

                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(times[0] +
                        ' or ' +
                        times[1] +
                        ' or ' +
                        times[2] +
                        ' or ' +
                        times[3] +
                        ' or ' +
                        times[4] +
                        ' or ' +
                        times[5],
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
