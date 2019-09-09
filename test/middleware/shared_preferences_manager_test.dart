import 'package:fogosmobile/middleware/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

const String _prefix = "flutter.";

void main() {
  SharedPreferencesManager _preferences;

  setUp(() async {
    Map<String, dynamic> initialValues = {};
    initialValues.addAll(_map("testBoolTrue", true));
    initialValues.addAll(_map("testBoolFalse", false));
    initialValues.addAll(_map("testInt1", 1));
    initialValues.addAll(_map("testInt-10", -10));
    initialValues.addAll(_map("testInt100", 100));
    SharedPreferences.setMockInitialValues(initialValues);
    await SharedPreferencesManager.init();
    _preferences = SharedPreferencesManager.preferences;
  });

  test('Test read boolean', () async {
    expect(_preferences.getBool("testBoolTrue"), true);
    expect(_preferences.getBool("testBoolFalse"), false);
  });

  test('Test read int', () async {
    expect(_preferences.getInt("testInt1"), 1);
    expect(_preferences.getInt("testInt-10"), -10);
    expect(_preferences.getInt("testInt100"), 100);
  });
}

Map<String, Object> _map(String key, dynamic value) {
  return {_prefix + key: value};
}
