import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Celsius to Fahrenheit Converter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _ctrlCelsius = TextEditingController();
  var msgResult = '';

  celsiusToFahrenheit() {
    double? _celsius = double.tryParse(_ctrlCelsius.text);
    if (_celsius == null) {
      setState(() {
        msgResult = 'Value is null. Type the temperature using Celsius';
      });
    } else {
      var _fahrenheit = (9 / 5) * _celsius + 32;
      setState(() {
        msgResult = '$_celsius ºC = $_fahrenheit ºF';
        // Esconde o teclado
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      });
    }
  }

  reset() {
    setState(() {
      msgResult = '';
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  msgResult,
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: _ctrlCelsius,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Type the temperature in Celsius',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        celsiusToFahrenheit();
                      },
                      
                      child: Text('Convert',
                          style: TextStyle(color: Color(0xFFFFFFFF))),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        reset();
                      },
                      child: Text('Reset'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}