import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int result = 0;
  TextEditingController firstValueController = TextEditingController();
  TextEditingController secondValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: TextField(
              controller: firstValueController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Primeiro valor",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: TextField(
              controller: secondValueController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Segundo valor",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _performOperation((n1, n2) => n1 + n2),
                child: const Text("Somar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff7422ad),
                ),
              ),
              ElevatedButton(
                onPressed: () => _performOperation((n1, n2) => n1 - n2),
                child: const Text("Subtrair"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff7422ad),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              "$result",
              style: const TextStyle(
                color: Color(0xff000000),
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performOperation(int Function(int, int) operation) {
    int n1 = int.tryParse(firstValueController.text) ?? 0;
    int n2 = int.tryParse(secondValueController.text) ?? 0;
    setState(() {
      result = operation(n1, n2);
    });
  }
}
