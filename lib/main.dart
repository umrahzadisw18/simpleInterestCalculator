import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "calculator App",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormstate();
  }
}

class _SIFormstate extends State<SIForm> {
  var _currencies = ["Rupees", "pounds", "Dollars"];
  var _currentItemSelected= "";
  var displayResult="";
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _currentItemSelected=_currencies[0];
  }
  TextEditingController prinicipalControlled = TextEditingController();
  TextEditingController rateControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      //    resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Interest Calculator App"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(padding: EdgeInsets.only(top: 20)),
              Center(
                child: Image.asset(
                  "assets/money.png",
                  width: 200,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: prinicipalControlled,
                  style: textStyle,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Please Enter Principal amount";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15,
                    ),
                    labelText: "principal",
                    hintText: "Enter principal eg.12000",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: rateControlled,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                    validator: (value) {
                    if(value!.isEmpty){
                      return "Please Enter Rate of Interest";
                    }
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15,
                    ),
                    labelText: "Rate of interest",
                    hintText: "In percent",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: termControlled,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                    if(value!.isEmpty){
                      return "Please Enter Term ";
                    }
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 15,
                    ),
                          labelText: "Term",
                          hintText: "Times in year",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 8.0,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value));
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (newValueSelected) {
                        _OnDropDownItemSelected(newValueSelected!);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                      child: Text(
                        "calculate",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState!.validate()){
                              this.displayResult=_calculateTotalReturns();
                          }
                        
                        });
                        
                      },
                    )),
                    Container(
                      width: 8.0,
                    ),
                    Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black38,
                          ),
                      child: Text(
                        "Reset",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white
                        )
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                this.displayResult,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _OnDropDownItemSelected(String newValueSelected) {
          setState(() {
          this._currentItemSelected=newValueSelected;
          });
  }
  
  String _calculateTotalReturns() {
    double principal=double.parse(prinicipalControlled.text) ;
    double rate=double.parse(rateControlled.text) ;
    double term=double.parse(termControlled.text) ;
    double totalAmountPayable=principal+(principal*rate*term)/100;
    String result = "After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected";
    return result;
  }
  
  void _reset() {
    prinicipalControlled.text="";
    rateControlled.text="";
    termControlled.text ="";
    displayResult="";
    _currentItemSelected=_currencies[0];
  }
}
