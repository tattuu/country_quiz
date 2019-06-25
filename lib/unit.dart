
import 'package:meta/meta.dart';

class Unit {
  final String name;
  final String flagPath;

  const Unit({
    @required this.name,
    @required this.flagPath,
  }) : assert(name != null),
       assert(flagPath != null);

  Unit.fromJson(Map jsonMap)
    : assert(jsonMap['jp_name'] != null),
      assert(jsonMap['flag_path'] != null),
      name = jsonMap['jp_name'],
      flagPath = jsonMap['flag_path'];
}