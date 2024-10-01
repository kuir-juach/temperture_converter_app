import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  // Variables for the app
  String _selectedConversion = 'F to C'; // Default conversion
  TextEditingController _tempController = TextEditingController();
  String _convertedTemp = '';
  List<String> _history = [];

  // Conversion logic: Fahrenheit to Celsius
  double _fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  // Conversion logic: Celsius to Fahrenheit
  double _celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  // Method to perform the conversion
  void _convertTemperature() {
    double inputTemp = double.tryParse(_tempController.text) ?? 0;
    double result;

    if (_selectedConversion == 'F to C') {
      result = _fahrenheitToCelsius(inputTemp);
      setState(() {
        _convertedTemp =
            '${inputTemp.toStringAsFixed(2)}°F => ${result.toStringAsFixed(2)}°C';
        _history.add(_convertedTemp);
      });
    } else {
      result = _celsiusToFahrenheit(inputTemp);
      setState(() {
        _convertedTemp =
            '${inputTemp.toStringAsFixed(2)}°C => ${result.toStringAsFixed(2)}°F';
        _history.add(_convertedTemp);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
              ),
            ),
            SizedBox(height: 16.0),

            // Conversion selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Text('Fahrenheit to Celsius'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: _selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      _selectedConversion = value!;
                    });
                  },
                ),
                Text('Celsius to Fahrenheit'),
              ],
            ),
            SizedBox(height: 16.0),

            // Convert button
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),

            // Result display
            Text(
              _convertedTemp,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),

            // Conversion history
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
