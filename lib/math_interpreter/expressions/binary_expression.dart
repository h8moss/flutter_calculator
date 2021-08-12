import 'expression.dart';

typedef BinaryOperation = double Function(double, double);

class BinaryExpression extends Expression {
  BinaryExpression(this.leftSide, this.rightSide, this.operation);

  Expression leftSide;
  Expression rightSide;
  BinaryOperation operation;

  @override
  double get evaluation => operation(leftSide.evaluation, rightSide.evaluation);
}
