

import 'package:flutter/material.dart';

class Calculate with ChangeNotifier {

  String currentInput = '';
  String operation = '';
  String num1 = '';
  String num2 = '';
  List<String> history = [];

  void addDigit(String digit) {
    if (operation.isEmpty) {
      if (num1 == '0') {
        num1 = digit;
      } else {
        if (num1.length >= 15) return;

        num1 += digit;
      }
      currentInput = num1;
    } else {
      if (num2 == '0') {
        num2 = digit;
      } else {
        if (num2.length >= 15) return;
        num2 += digit;
      }
      currentInput = '$num1 $operation $num2';
    }
    notifyListeners();
  }

  void setOperation(String op) {
    if (num1.isNotEmpty) {
      operation = op;
      currentInput = '$num1 $op';
    }
    notifyListeners();
  }

  void calculate() {
    if (num1.isNotEmpty && num2.isNotEmpty && operation.isNotEmpty) {
      int a = int.parse(num1);
      int b = int.parse(num2);

      int result = 0;
      switch (operation) {
        case '+':
          result = a + b;
          break;
        case '-':
          result = a - b;
          break;
        case '*':
          result = a * b;
          break;
        case '/':
          if (b != 0) result = a ~/ b;
          break;
      }

      history.insert(0, '$num1 $operation $num2 = ${result.toString()}');

      if (history.length > 5) {
        history.removeLast();
      }

      currentInput = result.toString();
      num1 = result.toString();
      num2 = '';
      operation = '';
    }
    notifyListeners();
  }

  void clear() {
    currentInput = '0';
    num1 = '';
    num2 = '';
    operation = '';
    notifyListeners();
  }

  void clearHistory() {
    history.clear();
    notifyListeners();
  }
}





