import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();

// If you want the data validation, GlobalKey is necessary.
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Enter the data!";

// Reset "Text Field"
  void _resetField() {
    firstController.text = "";
    secondController.text = "";
//Use setState when is necessary actualise anything in display interface.
    setState(() {
      _infoText = "Enter the data!";
    });
  }

// Logic for take value in textfield, conver to double and manipulate data.
  void _calculate() {
    setState(
      () {
        double first = double.parse(firstController.text);
        double second = double.parse(secondController.text);
        double result = first / second;
        if (result < 0) {
          _infoText = "Negative result = (${result.toStringAsPrecision(3)})";
        } else if (result >= 0) {
          _infoText = "Result is = (${result.toStringAsPrecision(3)})";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SAMPLE CALCULATOR"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,

      //SingleChildScrollView is not a common use for listview, bet is more simple.
      //This widget is useful when you have a single box that will normally be entirely visible,
      //but you need to make sure it can be scrolled if is necessary.
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),

        //The "Form" widget acts as a container for grouping and validating multiple form fields.
        //When creating the form, provide a GlobalKey. This uniquely identifies the Form, and allows validation of the form in a later step.
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.local_cafe,
                size: 120.0,
                color: Colors.deepPurple,
              ),

              //TextFormField is necessary to use with GlobalKey for data validation.
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Divide this:",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: firstController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Write in first value:";
                  }
                },
              ),
//------------------------------------------------------------------
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "By this:",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: secondController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "write in second value:";
                  }
                },
              ),
//------------------------------------------------------------------
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Start Calc",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.deepPurple,
                  ),
                ),
              ),

//Aditional text for send feddback to user after calculate.
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
