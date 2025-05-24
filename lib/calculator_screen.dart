

import 'package:calculator/calculator_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<Calculate>(context);
    double fontSize =getFontSizeToFit(calc.currentInput);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('К а л ь к у л я т о р'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  reverse: true,
                  itemCount: calc.history.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          calc.history[index],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        Divider(height: 4.0,)
                      ],
                    );
                  },
                ),
              )
            ),

            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Consumer<Calculate>(
                  builder:(context, calc, _) {
                    return Text(
                      calc.currentInput.isEmpty ? '0' : calc.currentInput,
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              )
            ),

            SizedBox(height: 60.0,),

            Table(
              children: [
                TableRow(children: [
                  CustomButton(onPressed: () => context.read<Calculate>().setOperation('+'), text: '+',),
                  CustomButton(onPressed: () => context.read<Calculate>().setOperation('-'), text: '-',),
                  CustomButton(onPressed: () => context.read<Calculate>().setOperation('*'), text: '*',),
                  CustomButton(onPressed: () => context.read<Calculate>().setOperation('/'), text: '/',),
                ]),
                TableRow(children: [
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('7'), text: '7',),
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('8'), text: '8',),
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('9'), text: '9',),
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('0'), text: '0',),
                ]),
                TableRow(children: [
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('4'), text: '4',),
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('5'), text: '5',),
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('6'), text: '6',),
                  CustomButton(onPressed: () => context.read<Calculate>().clear(), text: 'C',),
                ]),
                TableRow(children: [
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('1'), text: '1',),
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('2'), text: '2',),
                  CustomButton(onPressed: () => context.read<Calculate>().addDigit('3'), text: '3',),
                  CustomButton(onPressed: () => context.read<Calculate>().calculate(), text: '=',),
                ]),
              ],
            ),
            SizedBox(height: 40.0,)
          ],
        ),
      ),
    );
  }

  double getFontSizeToFit(String text) {
    if (text.length < 10) return 64;
    if (text.length < 13) return 48;
    if (text.length < 18) return 36;
    return 28;
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[300],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
        ),
        onPressed: onPressed,
        child: Text(text)
      ),
    );
  }
}




