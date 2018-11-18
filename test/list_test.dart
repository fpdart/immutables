import 'dart:math';

import 'package:test/test.dart';

void main() {
  test('empty list is empty', () {
    final empty = IList();
    expect(empty.isEmpty, true);
    expect(empty.isNotEmpty, false);
  });
}

class IList<E> {
  final List<E> _;

  get isEmpty => _.isEmpty;

  get isNotEmpty => _.isNotEmpty;

  IList([Iterable<E> elements]) : _ = List.from(elements ?? []);

  IList.filled(int length, E fill) : _ = List.filled(length, fill);

  IList.generate(int length, E generator(int index))
      : _ = List.generate(length, generator);

  E operator [](int index) => _[index];

  int get length => _.length;

  Iterable<E> get reversed => _.reversed;

  IList<E> sort([int compare(E a, E b)]) => IList(_).._.sort(compare);

  IList<E> shuffle([Random random]) => IList(_).._.shuffle(random);

  int indexOf(E element, [int start = 0]) => _.indexOf(element, start);

  int indexWhere(bool test(E element), [int start = 0]) =>
      _.indexWhere(test, start);

  int lastIndexWhere(bool test(E element), [int start]) =>
      _.lastIndexWhere(test, start);

  int lastIndexOf(E element, [int start]) => _.lastIndexOf(element, start);

  IList<E> insert(int index, E element) => IList(_).._.insert(index, element);

  IList<E> insertAll(int index, Iterable<E> iterable) =>
      IList(_).._.insertAll(index, iterable);

  IList<E> setAll(int index, Iterable<E> iterable) =>
      IList(_).._.setAll(index, iterable);

  IList<E> remove(E element) => IList(_).._.remove(element);

  IList<E> removeAt(int index) => IList(_).._.removeAt(index);

  IList<E> removeLast() => IList(_).._.removeLast();

  IList<E> removeWhere(bool test(E element)) => IList(_).._.removeWhere(test);

  IList<E> retainWhere(bool test(E element)) => IList(_).._.retainWhere(test);

  IList<E> operator +(IList<E> other) => IList(_ + other._);

  IList<E> sublist(int start, [int end]) => IList(_.sublist(start, end));

  Iterable<E> getRange(int start, int end) => _.getRange(start, end);

  IList<E> setRange(int start, int end, Iterable<E> iterable,
          [int skipCount = 0]) =>
      IList(_).._.setRange(start, end, iterable, skipCount);

  IList<E> removeRange(int start, int end) =>
      IList(_).._.removeRange(start, end);

  IList<E> fillRange(int start, int end, [E fillValue]) =>
      IList(_).._.fillRange(start, end, fillValue);

  IList<E> replaceRange(int start, int end, Iterable<E> replacement) =>
      IList(_).._.replaceRange(start, end, replacement);

  Map<int, E> asMap() => _.asMap();
}
