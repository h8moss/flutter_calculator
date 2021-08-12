class MathException implements Exception {
  MathException([this.message]);

  String? message;

  @override
  String toString() => 'MathException: $message';
}
