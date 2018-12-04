import 'package:immutables/immutables.dart';
import 'package:test/test.dart';

void main() {
  test('empty list is empty', () {
    final empty = IList();
    expect(empty.isEmpty, true);
    expect(empty.isNotEmpty, false);
  });

  test('can concat two lists', () {


  });
}
