import 'package:flutter/foundation.dart';
import 'expression_token.dart';

@immutable
class ExpressionCharacterData {
  ExpressionCharacterData(
      {this.value,
      required this.representation,
      required this.expectedTokenType});

  final int? value;
  final String representation;
  final ExpressionTokenType expectedTokenType;
}

class ExpressionCharacters {
  static List<ExpressionCharacterData> get values => [
        zero,
        one,
        two,
        three,
        four,
        five,
        six,
        seven,
        eight,
        nine,
        dot,
        plus,
        minus,
        multiplier,
        end,
      ];

  static ExpressionCharacterData get zero => _buildDigitConst(0);
  static ExpressionCharacterData get one => _buildDigitConst(1);
  static ExpressionCharacterData get two => _buildDigitConst(2);
  static ExpressionCharacterData get three => _buildDigitConst(3);
  static ExpressionCharacterData get four => _buildDigitConst(4);
  static ExpressionCharacterData get five => _buildDigitConst(5);
  static ExpressionCharacterData get six => _buildDigitConst(6);
  static ExpressionCharacterData get seven => _buildDigitConst(7);
  static ExpressionCharacterData get eight => _buildDigitConst(8);
  static ExpressionCharacterData get nine => _buildDigitConst(9);
  static ExpressionCharacterData get dot => ExpressionCharacterData(
      representation: '.', expectedTokenType: ExpressionTokenType.Number);
  static ExpressionCharacterData get plus => ExpressionCharacterData(
      representation: '+', expectedTokenType: ExpressionTokenType.Plus);
  static ExpressionCharacterData get minus => ExpressionCharacterData(
      representation: '-', expectedTokenType: ExpressionTokenType.Minus);
  static ExpressionCharacterData get multiplier => ExpressionCharacterData(
      representation: 'X',
      expectedTokenType: ExpressionTokenType.Multiplication);
  static ExpressionCharacterData get divider => ExpressionCharacterData(
      representation: '/', expectedTokenType: ExpressionTokenType.Division);

  static ExpressionCharacterData get end => ExpressionCharacterData(
      representation: '', expectedTokenType: ExpressionTokenType.None);

  static ExpressionCharacterData _buildDigitConst(int val) =>
      ExpressionCharacterData(
        representation: val.toString(),
        value: val,
        expectedTokenType: ExpressionTokenType.Number,
      );
}
