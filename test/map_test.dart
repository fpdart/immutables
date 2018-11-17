import 'package:immutables/immutables.dart';
import 'package:json_matcher/json_matcher.dart';
import 'package:test/test.dart';

void main() {
  final empty = IMap();
  final colors = IMap({'sky': 'blue', 'grass': 'green', 'sun': 'red'});
  final autumn = IMap({'leaves': 'yellow', 'grass': 'grey'});

  test('empty map is empty', () {
    expect(empty.isEmpty, true);
    expect(empty.isNotEmpty, false);
    expect(empty.length, 0);
    expect(empty.containsValue(42), false);
    expect(empty.containsKey(42), false);
    expect(empty['foo'], isNull);
  });

  test('can remove elements', () {
    final noSun = colors.removeWhere((k, v) => k == 'sun');
    expect(noSun.length, 2);
    expect(noSun.containsKey('sun'), false);
  });

  test('encodes to JSON', () {
    final json = {'foo': 'bar'};
    expect(IMap(json), encodesToJson(json));
  });

  test('union of keys', () {
    expect((colors + autumn).length, 4);
    expect((colors + autumn)['grass'], 'green');
    expect(colors.length, 3, reason: 'Should not mutate operands');
    expect(autumn.length, 2, reason: 'Should not mutate operands');
  });

  test('complement of keys', () {
    expect((colors - autumn).length, 2);
    expect((colors - autumn).containsKey('grass'), false);
    expect(colors.length, 3, reason: 'Should not mutate operands');
    expect(autumn.length, 2, reason: 'Should not mutate operands');
  });

  test('intersection of keys', () {
    final justGrass = colors ^ autumn;
    expect(justGrass.length, 1);
    expect(justGrass['grass'], 'green');
    expect(colors.length, 3, reason: 'Should not mutate operands');
    expect(autumn.length, 2, reason: 'Should not mutate operands');
  });
}

