import 'package:fogosmobile/middleware/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

const String _prefix = "flutter.";

void main() {
  SharedPreferencesManager _preferences;

  setUp(() async {
    Map<String, dynamic> initialValues = {};
    initialValues.addAll(_map("testReadBoolTrue", true));
    initialValues.addAll(_map("testReadBoolFalse", false));
    initialValues.addAll(_map("testReadInt1", 1));
    initialValues.addAll(_map("testReadInt-10", -10));
    initialValues.addAll(_map("testReadInt100", 100));
    initialValues.addAll(_map("testReadDouble0.0", 0.0));
    initialValues.addAll(_map("testReadDouble2.0", 2.0));
    initialValues.addAll(_map("testReadDouble-22.2", -22.2));
    initialValues.addAll(_map("testReadStringEmpty", ""));
    initialValues.addAll(_map("testReadString", "String"));
    List<String> stringList = new List();
    stringList.add("Item0");
    stringList.add("Item1");
    initialValues.addAll(_map("testReadStringList", stringList));
    initialValues.addAll(_map("testRemove", "testRemove"));
    SharedPreferences.setMockInitialValues(initialValues);
    await SharedPreferencesManager.init();
    _preferences = SharedPreferencesManager.preferences;
  });

  group("Test read", () {
    test('Test read boolean', () async {
      expect(_preferences.getBool("testReadBoolTrue"), true);
      expect(_preferences.getBool("testReadBoolFalse"), false);
    });

    test('Test read int', () async {
      expect(_preferences.getInt("testReadInt1"), 1);
      expect(_preferences.getInt("testReadInt-10"), -10);
      expect(_preferences.getInt("testReadInt100"), 100);
    });

    test('Test read double', () async {
      expect(_preferences.getDouble("testReadDouble0.0"), 0.0);
      expect(_preferences.getDouble("testReadDouble2.0"), 2.0);
      expect(_preferences.getDouble("testReadDouble-22.2"), -22.2);
    });

    test('Test read String', () async {
      expect(_preferences.getString("testReadStringEmpty"), "");
      expect(_preferences.getString("testReadString"), "String");
    });

    test('Test read String List', () async {
      List<String> stringList =
          _preferences.getStringList("testReadStringList");
      expect(stringList[0], "Item0");
      expect(stringList[1], "Item1");
    });
  });

  group("Test write", () {
    test('Test write boolean', () async {
      await _preferences.save("testWriteBoolTrue", true);
      await _preferences.save("testWriteBoolFalse", false);

      expect(_preferences.getBool("testWriteBoolTrue"), true);
      expect(_preferences.getBool("testWriteBoolFalse"), false);
    });

    test('Test read int', () async {
      await _preferences.save("testWriteInt1", 1);
      await _preferences.save("testWriteInt-10", -10);
      await _preferences.save("testWriteInt100", 100);

      expect(_preferences.getInt("testWriteInt1"), 1);
      expect(_preferences.getInt("testWriteInt-10"), -10);
      expect(_preferences.getInt("testWriteInt100"), 100);
    });

    test('Test read double', () async {
      await _preferences.save("testWriteDouble0.0", 0.0);
      await _preferences.save("testWriteDouble2.0", 2.0);
      await _preferences.save("testWriteDouble-22.2", -22.2);

      expect(_preferences.getDouble("testWriteDouble0.0"), 0.0);
      expect(_preferences.getDouble("testWriteDouble2.0"), 2.0);
      expect(_preferences.getDouble("testWriteDouble-22.2"), -22.2);
    });

    test('Test read String', () async {
      await _preferences.save("testWriteStringEmpty", "");
      await _preferences.save("testWriteString", "String");

      expect(_preferences.getString("testWriteStringEmpty"), "");
      expect(_preferences.getString("testWriteString"), "String");
    });

    test('Test read String List', () async {
      List<String> stringListWrite = new List();
      stringListWrite.add("Item0");
      stringListWrite.add("Item1");
      await _preferences.save("testWriteStringList", stringListWrite);

      List<String> stringList =
          _preferences.getStringList("testWriteStringList");
      expect(stringList[0], "Item0");
      expect(stringList[1], "Item1");
    });
  });

  group("Test remove", () {
    test('Test read String', () async {
      expect(_preferences.getString("testRemove"), "testRemove");
      await _preferences.remove("testRemove");
      expect(_preferences.getString("testRemove"), null);
    });
  });
}

Map<String, Object> _map(String key, dynamic value) {
  return {_prefix + key: value};
}
