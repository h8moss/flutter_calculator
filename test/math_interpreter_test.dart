import 'package:flutter_calculator/math_interpreter/expressions/addition_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/division_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/multiplication_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/substraction_expression.dart';
import 'package:flutter_calculator/math_interpreter/expressions/value_expression.dart';
import 'package:flutter_calculator/math_interpreter/models/expression_character.dart';
import 'package:flutter_calculator/math_interpreter/models/expression_token.dart';
import 'package:flutter_calculator/math_interpreter/parsers/expression_character_parser.dart';
import 'package:flutter_calculator/math_interpreter/parsers/math_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing character parser', () {
    ExpressionCharacterParser expParser = ExpressionCharacterParser();

    test('45 - 32', () {
      var expression = expParser
          .parse(ExpressionCharacterParser.charactersFromString('45 - 32'));

      expect(expression, [
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 45),
        ExpressionToken(tokenType: ExpressionTokenType.Minus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 32),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ]);
    });

    test('45 + 32', () {
      var expression = expParser.parse([
        ExpressionCharacters.four,
        ExpressionCharacters.five,
        ExpressionCharacters.plus,
        ExpressionCharacters.three,
        ExpressionCharacters.two,
      ]);

      expect(expression, [
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 45),
        ExpressionToken(tokenType: ExpressionTokenType.Plus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 32),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ]);
    });

    test('45 + 23 - 12', () {
      var expression = expParser.parse([
        ExpressionCharacters.four,
        ExpressionCharacters.five,
        ExpressionCharacters.plus,
        ExpressionCharacters.two,
        ExpressionCharacters.three,
        ExpressionCharacters.minus,
        ExpressionCharacters.one,
        ExpressionCharacters.two,
      ]);

      expect(expression, [
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 45),
        ExpressionToken(tokenType: ExpressionTokenType.Plus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 23),
        ExpressionToken(tokenType: ExpressionTokenType.Minus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 12),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ]);
    });

    test('1.2 - 6.4 + 8.3', () {
      var expression = expParser.parse([
        ExpressionCharacters.one,
        ExpressionCharacters.dot,
        ExpressionCharacters.two,
        ExpressionCharacters.minus,
        ExpressionCharacters.six,
        ExpressionCharacters.dot,
        ExpressionCharacters.four,
        ExpressionCharacters.plus,
        ExpressionCharacters.eight,
        ExpressionCharacters.dot,
        ExpressionCharacters.three,
      ]);

      expect(expression, [
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 1.2),
        ExpressionToken(tokenType: ExpressionTokenType.Minus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 6.4),
        ExpressionToken(tokenType: ExpressionTokenType.Plus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 8.3),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ]);
    });

    test('5 * 13', () {
      var expression = expParser.parse([
        ExpressionCharacters.five,
        ExpressionCharacters.multiplier,
        ExpressionCharacters.one,
        ExpressionCharacters.three
      ]);

      expect(expression, [
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 5),
        ExpressionToken(tokenType: ExpressionTokenType.Multiplication),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 13),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ]);
    });

    test('3 / 4', () {
      var expression = expParser.parse([
        ExpressionCharacters.three,
        ExpressionCharacters.divider,
        ExpressionCharacters.four,
      ]);
      expect(expression, [
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 3),
        ExpressionToken(tokenType: ExpressionTokenType.Division),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 4),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ]);
    });
  });

  group('Testing Math parser', () {
    MathParser parser = MathParser();

    test('Addition expression', () {
      Expression exp = parser.parse([
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 10),
        ExpressionToken(tokenType: ExpressionTokenType.Plus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 2),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ].iterator);

      expect(exp, isA<AdditionExpression>());
      expect((exp as AdditionExpression).leftSide, isA<ValueExpression>());
      expect((exp).rightSide, isA<ValueExpression>());
    });

    test('Substraction expression', () {
      Expression exp = parser.parse([
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 10),
        ExpressionToken(tokenType: ExpressionTokenType.Minus),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 2),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ].iterator);

      expect(exp, isA<SubstractionExpression>());
      expect((exp as SubstractionExpression).leftSide, isA<ValueExpression>());
      expect(exp.rightSide, isA<ValueExpression>());
    });

    test('Multiplication expression', () {
      Expression exp = parser.parse([
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 1.43),
        ExpressionToken(tokenType: ExpressionTokenType.Multiplication),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 3),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ].iterator);

      expect(exp, isA<MultiplicationExpression>());
      expect(
          (exp as MultiplicationExpression).leftSide, isA<ValueExpression>());
      expect(exp.rightSide, isA<ValueExpression>());
    });
    test('Division expression', () {
      Expression exp = parser.parse([
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 1.43),
        ExpressionToken(tokenType: ExpressionTokenType.Division),
        ExpressionToken(tokenType: ExpressionTokenType.Number, value: 3),
        ExpressionToken(tokenType: ExpressionTokenType.None),
      ].iterator);

      expect(exp, isA<DivisionExpression>());
      expect((exp as DivisionExpression).leftSide, isA<ValueExpression>());
      expect(exp.rightSide, isA<ValueExpression>());
    });
  });

  group('Expressions', () {
    test('Value 20', () {
      var exp = ValueExpression(20);

      expect(exp.evaluation, 20);
    });

    test('Addition 124 + 264', () {
      var exp = AdditionExpression(ValueExpression(124), ValueExpression(264));

      expect(exp.evaluation, 388);
    });

    test('Addition 23 + 53 + 12', () {
      var exp = AdditionExpression(
          AdditionExpression(ValueExpression(23), ValueExpression(53)),
          ValueExpression(12));

      expect(exp.evaluation, 88);
    });

    test('Substraction 10 - 3', () {
      var exp = SubstractionExpression(ValueExpression(10), ValueExpression(3));

      expect(exp.evaluation, 7);
    });

    test('substraction 123 - 23 - 99', () {
      var exp = SubstractionExpression(
          SubstractionExpression(ValueExpression(123), ValueExpression(23)),
          ValueExpression(99));

      expect(exp.evaluation, 1);
    });
    test('multiplication 5 * 13', () {
      var exp = MultiplicationExpression(
        ValueExpression(5),
        ValueExpression(13),
      );

      expect(exp.evaluation, 65);
    });

    test('multiplication 4 * 2 * 3', () {
      var exp = MultiplicationExpression(
          MultiplicationExpression(ValueExpression(4), ValueExpression(2)),
          ValueExpression(3));

      expect(exp.evaluation, 24);
    });
    test('division 5 / 4', () {
      var exp = DivisionExpression(
        ValueExpression(5),
        ValueExpression(4),
      );

      expect(exp.evaluation, 1.25);
    });

    test('division 4 / 2 / 3', () {
      var exp = DivisionExpression(
          DivisionExpression(ValueExpression(4), ValueExpression(2)),
          ValueExpression(3));

      expect(exp.evaluation.toStringAsFixed(4), '0.6667');
    });
  });

  group('Integration', () {
    ExpressionCharacterParser characterParser = ExpressionCharacterParser();
    MathParser mathParser = MathParser();
    test('12 - 54', () {
      var tokens = characterParser.parse([
        ExpressionCharacters.one,
        ExpressionCharacters.two,
        ExpressionCharacters.minus,
        ExpressionCharacters.five,
        ExpressionCharacters.four,
      ]);

      var expression = mathParser.parse(tokens.iterator);

      expect(expression.evaluation, -42);
    });

    test('14 + 23', () {
      var tokens = characterParser.parse([
        ExpressionCharacters.one,
        ExpressionCharacters.four,
        ExpressionCharacters.plus,
        ExpressionCharacters.two,
        ExpressionCharacters.three,
      ]);
      var expression = mathParser.parse(tokens.iterator);

      expect(expression.evaluation, 37);
    });

    test('23 + 53 - 1.24', () {
      var tokens = characterParser.parse([
        ExpressionCharacters.two,
        ExpressionCharacters.three,
        ExpressionCharacters.plus,
        ExpressionCharacters.five,
        ExpressionCharacters.three,
        ExpressionCharacters.minus,
        ExpressionCharacters.one,
        ExpressionCharacters.dot,
        ExpressionCharacters.two,
        ExpressionCharacters.four,
      ]);

      var expression = mathParser.parse(tokens.iterator);

      expect(expression.evaluation, 74.76);
    });

    test('11 - 5 - 2', () {
      var tokens = characterParser.parse([
        ExpressionCharacters.one,
        ExpressionCharacters.one,
        ExpressionCharacters.minus,
        ExpressionCharacters.five,
        ExpressionCharacters.minus,
        ExpressionCharacters.two,
      ]);

      var expression = mathParser.parse(tokens.iterator);

      expect(expression.evaluation, 4);
    });

    test('10 * 2', () {
      var tokens = characterParser.parse([
        ExpressionCharacters.one,
        ExpressionCharacters.zero,
        ExpressionCharacters.multiplier,
        ExpressionCharacters.two,
      ]);

      var expression = mathParser.parse(tokens.iterator);

      expect(expression.evaluation, 20);
    });

    test('10 * 2 + 3 - 5 / 2', () {
      var tokens = characterParser.parse([
        ExpressionCharacters.one,
        ExpressionCharacters.zero,
        ExpressionCharacters.multiplier,
        ExpressionCharacters.two,
        ExpressionCharacters.plus,
        ExpressionCharacters.three,
        ExpressionCharacters.minus,
        ExpressionCharacters.five,
        ExpressionCharacters.divider,
        ExpressionCharacters.two,
      ]);

      var expression = mathParser.parse(tokens.iterator);

      expect(expression.evaluation, 20.5);
    });
  });
}
