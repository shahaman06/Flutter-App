import 'package:flutter/material.dart';

void main() {
  runApp(MeasureConverterApp());
}

class MeasureConverterApp extends StatelessWidget {
  const MeasureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _valueController = TextEditingController();
  String? _fromUnit = "meters";
  String? _toUnit = "feet";
  String _result = "";

  final Map<String, double> conversionRates = {
    "meters to feet": 3.28084,
    "feet to meters": 0.3048,
    "kilograms to pounds": 2.20462,
    "pounds to kilograms": 0.453592
  };

  void _convert() {
    double value = double.tryParse(_valueController.text) ?? 0;
    String conversionKey = "$_fromUnit to $_toUnit";
    if (conversionRates.containsKey(conversionKey)) {
      double result = value * conversionRates[conversionKey]!;
      setState(() {
        _result = "$value $_fromUnit are ${result.toStringAsFixed(3)} $_toUnit";
      });
    } else {
      setState(() {
        _result = "Conversion not supported.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Measures Converter"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Value", style: TextStyle(fontSize: 18)),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            Text("From", style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _fromUnit,
              items: ["meters", "feet", "kilograms", "pounds"]
                  .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _fromUnit = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text("To", style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _toUnit,
              items: ["meters", "feet", "kilograms", "pounds"]
                  .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _toUnit = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: Text("Convert"),
            ),
            SizedBox(height: 16),
            Text(
              _result,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
