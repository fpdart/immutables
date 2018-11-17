class IList<E> {
  List<E> _value;

  List<E> get value => _toList();

  int get length => _value.length;

  E get first => _value.first;

  E get last => _value.last;

  E get head => first;

  IList<E> get tail => skip(1);

  bool get isEmpty => _value.isEmpty;

  IList(value) {
    if (value is List)
      _value = value;
    else
      this._value = List.from(value);
  }

  bool contains(E _) => _value.contains(_);

  E reduce(E f(E, E _)) => _value.reduce(f);

  T fold<T>(T _, T f(T, E)) => _value.fold(_, f);

  /**
  * The same with List.map()
  *
  *       IList([1, 2, 3]).map((value) => value + 1).value; // [2, 3, 4]
  *
  */
  IList map<T>(T f(E)) => fold(IList([]), (acc, _) => acc.add(f(_)));

  /**
   * 
   *      IList([1]).take(-1).value; // [1]
   *      IList([1]).take(0).value; // [1]
   *      IList([1, 2, 3]).take(2).value; // [1, 2]
   * 
   */
  IList<E> take(int length) =>
      0 >= length ? IList(_value.take(1)) : IList(_value.take(length));

  /**
   * 
   *      IList([1]).skip(-1).value; // [1]
   *      IList([1]).skip(0).value; // [1]
   *      IList([1, 2, 3]).skip(2).value; // [3]   
   * 
   */
  IList<E> skip(int length) =>
      0 > length ? IList(_value.skip(0)) : IList(_value.skip(length));

  /**
   * 
   *      IList([2, 4, 6, 8]).firstWhere((value) => 0 == (value % 2)); // 2
   * 
   */
  /* E | null */ firstWhere(bool f(E)) => _oneWhere(_value, f);

  /**
   * 
   *      IList([2, 4, 6, 8]).lastWhere((value) => 0 == (value % 2)); // 8
   * 
   */
  /* E | null */ lastWhere(bool f(E)) => _oneWhere(_value.reversed.toList(), f);

  /**
   * 
   *      IList([1, 2, 3, 4, 5]).removeWhere((value) => 0 == (value % 2)).value; // [1, 3, 5]
   * 
   */
  IList<E> removeWhere(bool f(E)) => IList(_toList()..removeWhere((_) => f(_)));

  /**
   * 
   *      IList([1, 2, 3, 4, 5]).removeWhere((value) => 0 == (value % 2)).value; // [1, 3, 5]
   * 
   */
  IList<E> filter(bool f(E)) => removeWhere((_) => !f(_));

  /**
   * 
   *      IList([1, 2, 3]).addAll([4, 5]).value; // 1, 2, 3, 4, 5
   * 
   */
  IList<E> addAll(List<E> _) => IList(<E>[]..addAll(_value)..addAll(_));

  /**
   * 
   *      IList([1, 2]).add(3).value; // [1, 2, 3]
   * 
   */
  IList<E> add(_) => _ is List ? addAll(_) : IList(_toList()..add(_));

  /**
   * 
   *      var a = IList([1, 2]) + 3;
   *      a.value; // [1, 2, 3]
   * 
   *      a = a + [4, 5];
   *      a.value; // [1, 2, 3, 4, 5]
   * 
   */
  IList<E> operator +(_) => add(_);

  /**
   * 
   *      IList([1, 2, 3, 4, 5]).removeContains([1, 2, 5]).value; // [3, 4]
   * 
   */
  IList<E> removeContains(List<E> _) => removeWhere((v) => _.contains(v));

  /**
   * 
   *      IList([1, 2, 3]).remove(3).value; // [1, 2]
   * 
   */
  IList<E> remove(_) =>
      _ is List ? removeContains(_) : IList(_toList()..remove(_));

  /**
   * 
   *      var a = IList([1, 2, 3, 4, 5]) - 3;
   *      a.value; // [1, 2, 4, 5]
   * 
   *      a = a - [4, 5];
   *      a.value; // [1, 2]
   * 
   */
  IList<E> operator -(_) => remove(_);

  E operator [](int index) => _value[index];

  void operator []=(int _, E value) => throw new Exception('Woops');

  List<E> _toList() => _value.toList();

  /* E | null */ _oneWhere(List<E> values, bool f(E _)) {
    for (var _ in values) if (f(_)) return _;
  }
}
