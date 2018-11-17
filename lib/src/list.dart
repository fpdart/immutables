class IList<E> {
  List<E> _value;

  List<E> get value => _value;

  int get length => _value.length;

  E get first => _value.first;

  E get last => _value.last;

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

  IList map<T>(T f(E)) => fold(IList([]), (acc, _) => acc.add(f(_)));

  IList<E> take(int length) =>
      0 >= length ? IList(_value.take(1)) : IList(_value.take(length));

  IList<E> skip(int length) =>
      0 > length ? IList(_value.skip(0)) : IList(_value.skip(length));

  /* E | null */ firstWhere(bool f(E)) {
    for (var _ in _value) if (f(_)) return _;
  }

  IList<E> removeWhere(bool f(E)) =>
      IList(_value.toList()..removeWhere((_) => f(_)));

  IList<E> removeWhereBool(bool f(E)) => removeWhere(f);

  IList<E> filter(bool f(E)) => removeWhere((_) => !f(_));

  IList<E> addAll(List<E> _) => IList(<E>[]..addAll(_value)..addAll(_));

  IList<E> add(_) => _ is List ? addAll(_) : IList(_value.toList()..add(_));

  IList<E> operator +(_) => add(_);

  IList<E> remove(_) => _ is List
      ? removeWhere((v) => _.contains(v))
      : IList(_value.toList()..remove(_));

  IList<E> operator -(_) => remove(_);

  E operator [](int index) => _value[index];

  void operator []=(int _, E value) => throw new Exception('Woops');
}
