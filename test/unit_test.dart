import 'package:test/test.dart';
import 'package:country_quiz/main.dart';

void main() {

  test('Test order of operations: 12 + 3 * 4 = 24', () {
    const int expression = 12 + 3 * 4;
    expect(expression, equals(24));
  });
}