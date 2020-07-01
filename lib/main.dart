import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'IfSleepNowPage.dart';
import 'package:intl/intl.dart';
import './sleepPage.dart';
import './wakeupPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'SleepScheduler'),




    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  final myController = TextEditingController();
  var currDt = DateTime.now();
  var wakepast = 'AM';

  final _formSleepKey = GlobalKey<FormState>();
  final _formWakeUPKey = GlobalKey<FormState>();
  var wakehour;
  var wakeminute;
  var sleeptimes = [];

  var sleephour;
  var sleepminute;
  var wakeuptimes = [];
  var sleeppast = 'AM';

  void calculatorSleepTime(){

    if(wakepast == 'AM' && int.parse(wakehour)<10){
      wakehour = '0'+wakehour;
    }else{
      wakehour = (int.parse(wakehour)+12).toString();
    }

    String day = DateFormat('yyyyMMdd').format(currDt);
    String date = day+wakehour+wakeminute;
    String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
    DateTime wakeTime = DateTime.parse(dateWithT);

    for(int i=1; i<7; i++){
      var time = wakeTime.subtract(new Duration(minutes: 90*i));
      print(DateFormat.jm().format(time));
      setState(() {
        sleeptimes.add(DateFormat.jm().format(time));
      });
    }
    print(sleeptimes);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SleepPage(times: sleeptimes))).then((_) => refresh());

  }

  void calculatorWakeTime(){
    if(sleeppast == 'AM'){
      sleephour = '0'+sleephour;
    }else{
      sleephour = (int.parse(sleephour)+12).toString();
    }

    String day = DateFormat('yyyyMMdd').format(currDt);
    String date = day+sleephour+sleepminute;
    String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
    DateTime sleepTime = DateTime.parse(dateWithT);
    print(sleepTime);
    for(int i=1; i<7; i++){
      var time = sleepTime.add(new Duration(minutes: 90*i -4));
      print(DateFormat.jm().format(time));
      setState(() {
        wakeuptimes.add(DateFormat.jm().format(time));
      });
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WakeUpPage(times: wakeuptimes))).then((_) => refresh());
  }

  void refresh(){
    setState(() {
      sleeptimes = [];
      wakeuptimes = [];
    });
  }
  void calculatorSleepNow(){
    String date = DateFormat('yyyyMMddkkmm').format(currDt);
    String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
    DateTime sleepTime = DateTime.parse(dateWithT);
    print(sleepTime);
    for(int i=1; i<7; i++){
      var time = sleepTime.add(new Duration(minutes: 90*i -4));
      print(DateFormat.jm().format(time));
      setState(() {
        wakeuptimes.add(DateFormat.jm().format(time));
      });
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WakeUpPage(times: wakeuptimes))).then((_) => refresh());
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Text("When should I sleep if I need to wake up at:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ],
                ),
                  Form(
                    key: _formSleepKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: myController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Hour',
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return "This field is required!";
                            }else if(int.parse(value) < 1 && int.parse(value)>12){
                              return "Hour has values between 1 to 12.";
                            }
                            wakehour = value;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Minute',
                          ),
                          validator: (value){
                            if(value.isEmpty){
                              return "This field is required!";
                            }else if(value.length!=2){
                              return "Minute length must be 2.";
                            }
                            wakeminute = value;
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              width: 1,
                                color: Colors.grey[500]
                            )
                          ),
                          child: FormField(
                            builder: (FormFieldState state){
                              return InputDecorator(
                                decoration: InputDecoration(

                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: wakepast,
                                    isDense: true,
                                    onChanged: (String newValue){
                                      setState(() {
                                        wakepast = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: <String>['AM','PM'].map((String value) {
                                      return new DropdownMenuItem(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            if(_formSleepKey.currentState.validate()){
                              calculatorSleepTime();
                            }
                            /*...*/
                          },
                          child: Text(
                            "Calculate",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text("When should I wake up if I plan to sleep at:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20), ),
                    ],
                  ),
                Form(
                  key: _formWakeUPKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Hour',
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "This field is required!";
                          }else if(int.parse(value) < 1 && int.parse(value)>12){
                            return "Hour has values between 1 to 12.";
                          }
                          sleephour = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Minute',
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "This field is required!";
                          }else if(value.length!=2){
                            return "Minute length must be 2.";
                          }
                          sleepminute = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                                width: 1,
                                color: Colors.grey[500]
                            )
                        ),
                        child: FormField(
                          builder: (FormFieldState state){
                            return InputDecorator(
                              decoration: InputDecoration(

                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: sleeppast,
                                  isDense: true,
                                  onChanged: (String newValue){
                                    setState(() {
                                      sleeppast = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: <String>['AM','PM'].map((String value) {
                                    return new DropdownMenuItem(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          if(_formWakeUPKey.currentState.validate()){
                            calculatorWakeTime();
                            setState(() {
                              sleeptimes = [];
                            });

                          }
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          calculatorSleepNow();
                        },
                        child: Text(
                          "I'm going to sleep now",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      )
                        ],
                  ),
              ],
            ),

          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
