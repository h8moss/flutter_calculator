import 'binary_expression.dart';
import 'expression.dart';

class SubstractionExpression extends BinaryExpression {
  SubstractionExpression(Expression leftSide, Expression rightSide)
      : super(leftSide, rightSide, (a, b) => a - b);
}
