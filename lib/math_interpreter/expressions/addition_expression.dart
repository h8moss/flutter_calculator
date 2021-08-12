import 'binary_expression.dart';
import 'expression.dart';

class AdditionExpression extends BinaryExpression {
  AdditionExpression(Expression leftSide, Expression rightSide)
      : super(leftSide, rightSide, (a, b) => a + b);
}
