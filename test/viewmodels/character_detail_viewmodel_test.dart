import 'package:flutter_test/flutter_test.dart';
import 'package:character_finder/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CharacterDetailViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
