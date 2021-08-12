import 'package:flutter_calculator/math_interpreter/models/expression_character.dart';
import 'package:flutter_calculator/math_interpreter/models/expression_token.dart';
import 'package:flutter_calculator/math_interpreter/models/math_exception.dart';

class ExpressionCharacterParser {
  static List<ExpressionCharacterData> charactersFromString(String text) {
    List<ExpressionCharacterData> result = [];
    for (int i = 0; i < text.length; i++) {
      for (var token in ExpressionCharacters.values) {
        if (text[i] == token.representation) {
          result.add(token);
          break;
        }
      }
    }
    return result;
  }

  List<ExpressionToken> parse(List<ExpressionCharacterData> characterData) {
    if (characterData.last != ExpressionCharacters.end)
      characterData.add(ExpressionCharacters.end);

    List<ExpressionToken> result = [];
    String number = '';

    for (int i = 0; i < characterData.length; i++) {
      bool endLoop = false;
      var current = characterData[i];
      switch (current.expectedTokenType) {
        case ExpressionTokenType.Number:
          number += current.representation;
          break;
        case ExpressionTokenType.None:
          endLoop = true;
          continue nonNumber;
        nonNumber:
        case ExpressionTokenType.Plus:
        case ExpressionTokenType.Minus:
        case ExpressionTokenType.Multiplication:
        case ExpressionTokenType.Division:
          double? parsedNumber = double.tryParse(number);
          number = '';
          if (parsedNumber == null)
            throw MathException('Failed to understand number');
          result.add(ExpressionToken(
              tokenType: ExpressionTokenType.Number, value: parsedNumber));
          if (!endLoop)
            result.add(ExpressionToken(tokenType: current.expectedTokenType));
          break;
      }
    }
    result.add(ExpressionToken(tokenType: ExpressionTokenType.None));
    return result;
  }
}
