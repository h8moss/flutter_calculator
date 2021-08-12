import 'expression.dart';

class ValueExpression extends Expression {
  ValueExpression(this.value);

  double value;

  @override
  double get evaluation => value;
}
