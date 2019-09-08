import 'dart:convert' show utf8;
import 'dart:convert';

import 'package:fogosmobile/models/fire.dart';
import 'package:fogosmobile/utils/model_utils.dart';
import 'package:resource/resource.dart' show Resource;
import 'package:test/test.dart';

void main() {
  String firesListInput;

  setUp(() async {
    firesListInput = await loadFiles().catchError((error) {
      print(error);
    });
  });

  test('Test _getPonderatedImportanceFactor', () {
    final responseData = json.decode(firesListInput)["data"];
    List<Fire> fires =
        responseData.map<Fire>((model) => Fire.fromJson(model)).toList();

    fires = calculateFireImportance(fires);

    expect(fires.length, 2);
    expect(fires[0].importance, 29);
    expect(fires[1].importance, 13);
  });
}

Future<String> loadFiles() async {
  final firesListInputResource =
      new Resource("./test_assets/utils/model_utils_test_input.json");

  final firesListInput =
      await firesListInputResource.readAsString(encoding: utf8);
  return firesListInput;
}
