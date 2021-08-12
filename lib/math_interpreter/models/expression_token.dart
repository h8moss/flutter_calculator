import 'package:equatable/equatable.dart';

enum ExpressionTokenType {
  None,
  Number,
  Plus,
  Minus,
  Multiplication,
  Division,
}

/// The atom of any expression, represents a value or an operation
class ExpressionToken extends Equatable {
  ExpressionToken({required this.tokenType, this.value})
      : assert(value != null || tokenType != ExpressionTokenType.Number);

  final ExpressionTokenType tokenType;
  final double? value;

  @override
  List<Object?> get props => [tokenType, value];
}
