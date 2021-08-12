import 'package:flutter_calculator/math_interpreter/expressions/binary_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/expression.dart';

class MultiplicationExpression extends BinaryExpression {
  MultiplicationExpression(
    Expression leftSide,
    Expression rightSide,
  ) : super(
          leftSide,
          rightSide,
          (a, b) => a * b,
        );
}
