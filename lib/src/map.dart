/// Immutable Map.
///
/// It is a wrapper over a regular [Map]. All read-only methods and operators
/// are proxied to the corresponding methods of the underlying map object.
class IMap<K, V> {
  IMap([Map<K, V> map = const {}]) : _ = Map<K, V>.from(map);

  IMap.fromIterable(Iterable iterable, {K key(element), V value(element)})
      : _ = Map<K, V>.fromIterable(iterable, key: key, value: value);

  IMap.fromIterables(Iterable<K> keys, Iterable<V> values)
      : _ = Map<K, V>.fromIterables(keys, values);

  IMap.fromEntries(Iterable<MapEntry<K, V>> entries)
      : _ = Map<K, V>.fromEntries(entries);

  final Map<K, V> _;

  bool containsValue(V value) => _.containsValue(value);

  bool containsKey(K key) => _.containsKey(key);

  V operator [](K key) => _[key];

  Iterable<MapEntry<K, V>> get entries => _.entries;

  IMap<K2, V2> map<K2, V2>(MapEntry<K2, V2> f(K key, V value)) =>
      IMap<K2, V2>(_.map(f));

  IMap<K, V> removeWhere(bool predicate(K key, V value)) =>
      IMap(_).._.removeWhere(predicate)

  void forEach(void f(K key, V value)) => _.forEach(f);

  Iterable<K> get keys => _.keys;

  Iterable<V> get values => _.values;

  int get length => _.length;

  bool get isEmpty => _.isEmpty;

  bool get isNotEmpty => _.isNotEmpty;

  /// Returns an unmodifiable map.
  ///
  /// This methods allow [IMap] to be used by dart:convert.
  Map<K, V> toJson() => Map.unmodifiable(_);

  /// Union of keys.
  ///
  /// Returns a new [IMap] where the keys are the union of keys from both maps.
  /// If both maps have the same key, the value from the left operand
  /// will be used.
  IMap<K, V> operator +(IMap<K, V> other) => IMap(Map.from(other._)..addAll(_));

  /// Absolute complement of keys.
  ///
  /// Returns a new [IMap] with all elements from the left operand
  /// except those whose keys are also in the right operand.
  IMap<K, V> operator -(IMap<K, V> other) =>
      removeWhere((k, v) => other.containsKey(k));

  /// Intersection of keys.
  ///
  /// Returns a new [IMap] with all elements from the left operand
  /// whose keys are also in the right operand.
  IMap<K, V> operator ^(IMap<K, V> other) =>
      removeWhere((k, v) => !other.containsKey(k));
}
