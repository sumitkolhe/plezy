import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/utils/json_utils.dart';

void main() {
  group('flexibleInt', () {
    test('parses int as-is', () {
      expect(flexibleInt(42), 42);
      expect(flexibleInt(0), 0);
      expect(flexibleInt(-7), -7);
    });

    test('truncates double to int', () {
      expect(flexibleInt(3.9), 3);
      expect(flexibleInt(-3.9), -3);
    });

    test('parses numeric string', () {
      expect(flexibleInt('123'), 123);
      expect(flexibleInt('-45'), -45);
    });

    test('returns null for unparseable string', () {
      expect(flexibleInt('abc'), isNull);
      expect(flexibleInt('12abc'), isNull);
      expect(flexibleInt(''), isNull);
    });

    test('returns null for null or unsupported types', () {
      expect(flexibleInt(null), isNull);
      expect(flexibleInt(true), isNull);
      expect(flexibleInt(<int>[1]), isNull);
      expect(flexibleInt(<String, Object>{'a': 1}), isNull);
    });
  });

  test('stringOrEmpty stringifies values and defaults null', () {
    expect(stringOrEmpty('value'), 'value');
    expect(stringOrEmpty(42), '42');
    expect(stringOrEmpty(true), 'true');
    expect(stringOrEmpty(null), '');
  });

  group('flexibleBoolNullable', () {
    test('returns bool as-is', () {
      expect(flexibleBoolNullable(true), isTrue);
      expect(flexibleBoolNullable(false), isFalse);
    });

    test('maps 1 to true, other ints to false', () {
      expect(flexibleBoolNullable(1), isTrue);
      expect(flexibleBoolNullable(0), isFalse);
      expect(flexibleBoolNullable(2), isFalse);
    });

    test("maps '1' and true strings to true, false strings to false", () {
      expect(flexibleBoolNullable('1'), isTrue);
      expect(flexibleBoolNullable('true'), isTrue);
      expect(flexibleBoolNullable('TRUE'), isTrue);
      expect(flexibleBoolNullable('0'), isFalse);
      expect(flexibleBoolNullable('false'), isFalse);
      expect(flexibleBoolNullable('FALSE'), isFalse);
    });

    test('returns null for null and unsupported types', () {
      expect(flexibleBoolNullable(null), isNull);
      expect(flexibleBoolNullable(1.0), isNull);
      expect(flexibleBoolNullable(<String, Object>{}), isNull);
    });
  });

  group('flexibleDouble', () {
    test('parses num as double', () {
      expect(flexibleDouble(1.5), 1.5);
      expect(flexibleDouble(2), 2.0);
      expect(flexibleDouble(0), 0.0);
    });

    test('parses numeric string', () {
      expect(flexibleDouble('3.14'), 3.14);
      expect(flexibleDouble('-2.5'), -2.5);
      expect(flexibleDouble('7'), 7.0);
    });

    test('returns null for unparseable string', () {
      expect(flexibleDouble('abc'), isNull);
      expect(flexibleDouble(''), isNull);
    });

    test('returns null for null and unsupported types', () {
      expect(flexibleDouble(null), isNull);
      expect(flexibleDouble(true), isNull);
      expect(flexibleDouble(<int>[1]), isNull);
    });
  });

  group('readStringField', () {
    test('coerces int to String', () {
      expect(readStringField({'x': 42}, 'x'), '42');
    });

    test('coerces double to String', () {
      expect(readStringField({'x': 3.14}, 'x'), '3.14');
    });

    test('leaves String alone', () {
      expect(readStringField({'x': 'hello'}, 'x'), 'hello');
    });

    test('returns null for missing key', () {
      expect(readStringField({'x': 1}, 'y'), isNull);
    });

    test('returns null for null value', () {
      expect(readStringField({'x': null}, 'x'), isNull);
    });
  });
}
