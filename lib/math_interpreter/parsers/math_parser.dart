import 'package:flutter_calculator/math_interpreter/expressions/addition_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/division_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/multiplication_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/substraction_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/value_expression.dart';
import 'package:flutter_calculator/math_interpreter/models/expression_token.dart';
import 'package:flutter_calculator/math_interpreter/models/math_exception.dart';

class MathParser {
  Expression parse(Iterator<ExpressionToken> tokens) {
    tokens.moveNext();
    var exp = _parseAddSubstract(tokens);

    if (tokens.current.tokenType != ExpressionTokenType.None)
      throw MathException('Expected End of list');
    return exp;
  }

  Expression _parseAddSubstract(Iterator<ExpressionToken> tokens) {
    var leftHand = _parseMultiDivision(tokens);

    while (true) {
      if (tokens.current.tokenType == ExpressionTokenType.Plus) {
        tokens.moveNext();
        var rightHand = _parseMultiDivision(tokens);
        leftHand = AdditionExpression(leftHand, rightHand);
      } else if (tokens.current.tokenType == ExpressionTokenType.Minus) {
        tokens.moveNext();
        var rightHand = _parseMultiDivision(tokens);
        leftHand = SubstractionExpression(leftHand, rightHand);
      } else {
        return leftHand;
      }
    }
  }

  Expression _parseMultiDivision(Iterator<ExpressionToken> tokens) {
    var leftHand = _parseLeaf(tokens);

    while (true) {
      if (tokens.current.tokenType == ExpressionTokenType.Multiplication) {
        tokens.moveNext();
        var rightHand = _parseLeaf(tokens);
        leftHand = MultiplicationExpression(leftHand, rightHand);
      } else if (tokens.current.tokenType == ExpressionTokenType.Division) {
        tokens.moveNext();
        var rightHand = _parseLeaf(tokens);
        leftHand = DivisionExpression(leftHand, rightHand);
      } else {
        return leftHand;
      }
    }
  }

  Expression _parseLeaf(Iterator<ExpressionToken> tokens) {
    if (tokens.current.tokenType == ExpressionTokenType.Number) {
      var exp = ValueExpression(tokens.current.value!);
      tokens.moveNext();
      return exp;
    }

    throw MathException('Could not understand math value');
  }
}
