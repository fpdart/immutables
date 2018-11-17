import 'package:immutables/immutables.dart';
import 'package:test/test.dart';

void main() {
  var a = IList<int>([1]);
  var b = IList<String>(['q']);
  var c = IList<int>([1, 2, 3]);
  var d = IList([
    {'a': 1},
    {'b': 2}
  ]);

  test('Getters', () {
    expect(a.length, 1);
    expect(b.length, 1);
    expect(c.length, 3);
    expect(d.length, 2);

    expect(a.first, 1);
    expect(b.first, 'q');
    expect(c.first, 1);
    expect(d.first, {'a': 1});

    expect(a.last, 1);
    expect(b.last, 'q');
    expect(c.last, 3);
    expect(d.last, {'b': 2});

    expect(a.isEmpty, false);
    expect(b.isEmpty, false);
    expect(c.isEmpty, false);
    expect(d.isEmpty, false);
    expect(IList([]).isEmpty, true);
  });

  test('Contains', () {
    expect(a.contains(1), true);
    expect(a.contains(2), false);

    expect(b.contains('e'), false);
    expect(b.contains('q'), true);

    expect(c.contains(2), true);
    expect(c.contains(3), true);
    expect(c.contains(0), false);
  });

  test('reduce', () {
    expect(a.reduce((acc, value) => value + 1), 1);
    expect(b.reduce((acc, value) => value + 'w'), 'q');
    expect(c.reduce((acc, value) => acc + value), 6);
    expect(d.reduce((acc, value) => {'b': 2}), {'b': 2});
  });

  test('Fold', () {
    expect(a.fold(1, (acc, value) => value + 1), 2);
    expect(b.fold('w', (acc, value) => value + 'w'), 'qw');
    expect(c.fold(0, (acc, value) => acc + value), 6);
    expect(d.fold({'c': 2}, (acc, value) => acc), {'c': 2});
  });

  test('Map', () {
    expect(a.map((_) => _ + 1).value, IList([2]).value);
    expect(b.map((_) => _ + 'w').value, IList(['qw']).value);
    expect(
        c.map((_) => {'a': _}).value,
        IList([
          {'a': 1},
          {'a': 2},
          {'a': 3}
        ]).value);
  });

  test('take', () {
    expect(a.take(-1).value, [1]);
    expect(a.take(0).value, [1]);
    expect(a.take(2).value, [1]);

    expect(b.take(-1).value, ['q']);
    expect(b.take(0).value, ['q']);
    expect(b.take(2).value, ['q']);

    expect(c.take(-1).value, [1]);
    expect(c.take(0).value, [1]);
    expect(c.take(2).value, [1, 2]);
    expect(c.take(44444).value, [1, 2, 3]);
  });

  test('skip', () {
    expect(a.skip(-1).value, [1]);
    expect(a.skip(0).value, [1]);
    expect(a.skip(2).value, []);

    expect(b.skip(-1).value, ['q']);
    expect(b.skip(0).value, ['q']);
    expect(b.skip(2).value, []);

    expect(c.skip(-1).value, [1, 2, 3]);
    expect(c.skip(0).value, [1, 2, 3]);
    expect(c.skip(2).value, [3]);
    expect(c.skip(44444).value, []);
  });

  test('firstWhere', () {
    expect(a.firstWhere((_) => _ == 2), null);
    expect(a.firstWhere((_) => _ == 1), 1);
    expect(a.value, [1]);

    expect(b.firstWhere((_) => _ == 'ww'), null);
    expect(b.firstWhere((_) => _ == 'q'), 'q');
    expect(b.value, ['q']);

    expect(c.firstWhere((_) => _ == 2), 2);
    expect(c.firstWhere((_) => _ == 1), 1);
    expect(c.firstWhere((_) => _ == 0), null);
    expect(c.value, [1, 2, 3]);
  });

  test('removeWhereBool', () {
    expect(a.removeWhereBool((_) => _ == 1).value, []);
    expect(a.removeWhereBool((_) => _ == 0).value, [1]);
    expect(a.value, [1]);

    expect(b.removeWhereBool((_) => _ == 'q').value, []);
    expect(b.removeWhereBool((_) => _ == 'w').value, ['q']);
    expect(b.value, ['q']);

    expect(c.removeWhereBool((_) => _ == 1).value, [2, 3]);
    expect(c.removeWhereBool((_) => _ == 2).value, [1, 3]);
    expect(c.removeWhereBool((_) => _ == 3).value, [1, 2]);
    expect(c.removeWhereBool((_) => _ == 4).value, [1, 2, 3]);
    expect(c.value, [1, 2, 3]);
  });

  test('filter', () {
    expect(a.filter((_) => _ == 1).value, [1]);
    expect(a.filter((_) => _ == 2).value, []);
    expect(a.value, [1]);

    expect(b.filter((_) => _ == 'q').value, ['q']);
    expect(b.filter((_) => _ == 'w').value, []);
    expect(b.value, ['q']);

    expect(c.filter((_) => _ == 1).value, [1]);
    expect(c.filter((_) => _ == 2).value, [2]);
    expect(c.filter((_) => 1 == _ || 2 == _).value, [1, 2]);
    expect(c.filter((_) => 0 == (_ % 2)).value, [2]);
    expect(c.value, [1, 2, 3]);
  });

  test('Add', () {
    expect(a.add(1).value, [1, 1]);
    expect(a.add(1).add(2).add(3).value, [1, 1, 2, 3]);
    expect(a.value, [1]);

    expect(b.add('w').value, ['q', 'w']);
    expect(b.value, ['q']);
  });

  group('+ operator', () {
    test('With common types', () {
      expect((a + 1).value, [1, 1]);
      expect((a + 1 + 2 + 3).value, [1, 1, 2, 3]);
      expect(a.value, [1]);

      expect((b + 'w').value, ['q', 'w']);
      expect(b.value, ['q']);
    });

    test('With list', () {
      expect((a + [2, 3]).value, [1, 2, 3]);
      expect(a.value, [1]);

      expect((b + ['w', 'e']).value, ['q', 'w', 'e']);
      expect(b.value, ['q']);
    });
  });

  test('Remove', () {
    expect(a.remove(1).value, []);
    expect(a.remove(0).value, [1]);
    expect(a.value, [1]);

    expect(c.remove(1).value, [2, 3]);
    expect(c.value, [1, 2, 3]);
  });

  group('- operator', () {
    test('With common types', () {
      expect((a - 1).value, []);
      expect((a - 0).value, [1]);
      expect(a.value, [1]);

      expect((c - 1).value, [2, 3]);
      expect(c.value, [1, 2, 3]);
    });

    test('With common list', () {
      expect((a - [1, 2]).value, []);
      expect((a - [2]).value, [1]);
      expect(a.value, [1]);

      expect((c - [1]).value, [2, 3]);
      expect((c - [2, 3]).value, [1]);
      expect(c.value, [1, 2, 3]);
    });
  });

  test('[] operator', () {
    expect(a[0], 1);
    expect(b[0], 'q');
    expect(c[0], 1);
    expect(c[1], 2);
    expect(c[2], 3);
  });
}
