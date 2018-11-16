# Imutable data structures

### List, ...

### Examples

```dart
var c = IList<int>([1, 2, 3]);

print((c + 4).value); // [1, 2, 3, 4]
print(c.value); // [1, 2, 3]

print((c - 3).value); // [1, 2]
print(c.value); // [1, 2, 3]

print(c.take(2).value); // [1, 2]
print(c.value); // [1, 2]

print(c.filter((_) => 1 == _ || 2 == _).value); // [1, 2]
print(c.value); // [1, 2, 3]
```
