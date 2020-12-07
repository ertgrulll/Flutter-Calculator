import "dart:math";

class Calc {
  String operation = "", placeHolder = "0", func = "";
  num counter = 0,
      firstNum = 0,
      secondNum = 0,
      currentNum = 0,
      res = 0,
      decimalCounter = 1;
  bool isDecimal = false;

  void reset() {
    operation = "";
    placeHolder = "0";
    firstNum = 0;
    secondNum = 0;
    counter = 0;
    currentNum = 0;
    isDecimal = false;
    decimalCounter = 1;
    res = 0;
  }

  void numPress(number) {
    if (counter > 5) return;
    if (!isDecimal) {
      currentNum = (currentNum * 10) + number;
      placeHolder = currentNum.toString();
    } else {
      if (number == 0) return;
      currentNum = (currentNum + (number * pow(0.1, decimalCounter)));
      placeHolder = currentNum.toString();
      decimalCounter++;
    }
    counter++;
  }

  void decimal() {
    if (isDecimal) return;
    isDecimal = true;
    currentNum = currentNum / 1.0;
    placeHolder = currentNum.toString();
  }

  void funcPress(func) {
    this.func = func;
    firstNum = currentNum;
    operation = firstNum.toString() + " " + func;
    placeHolder = "0";
    currentNum = 0;
    counter = 0;
    isDecimal = false;
  }

  void reverse() {
    currentNum = -1 * currentNum;
    placeHolder = currentNum.toString();
  }

  void equals() {
    secondNum = currentNum;
    operation = firstNum.toString() + " $func " + secondNum.toString() + " =";
    switch (this.func) {
      case "-":
        {
          placeHolder = (firstNum - secondNum).toString().length > 10
              ? (firstNum - secondNum).toString().substring(0, 9) + ".."
              : (firstNum - secondNum).toString();
          break;
        }
      case "+":
        {
          placeHolder = (firstNum + secondNum).toString().length > 10
              ? (firstNum + secondNum).toString().substring(0, 9) + ".."
              : (firstNum + secondNum).toString();
          break;
        }
      case "x":
        {
          placeHolder = (firstNum * secondNum).toString().length > 10
              ? (firstNum * secondNum).toString().substring(0, 9) + ".."
              : (firstNum * secondNum).toString();
          break;
        }
      case "%":
        {
          if (secondNum == 0) return;
          placeHolder = (firstNum % secondNum).toString().length > 10
              ? (firstNum % secondNum).toString().substring(0, 9) + ".."
              : (firstNum % secondNum).toString();
          break;
        }
      case "÷":
        {
          if (secondNum == 0) return;
          placeHolder = (firstNum / secondNum).toString().length > 10
              ? (firstNum / secondNum).toString().substring(0, 9) + ".."
              : (firstNum / secondNum).toString();
          break;
        }
    }
    if (placeHolder.contains("..")) {
      res = int.tryParse(placeHolder.substring(0, placeHolder.length - 2));
    } else
      res = int.tryParse(placeHolder);

    counter = 0;
    firstNum = 0;
    secondNum = 0;
    currentNum = res;
    isDecimal = false;
    decimalCounter = 1;
  }
}
