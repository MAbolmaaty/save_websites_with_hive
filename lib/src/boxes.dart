import 'package:hive/hive.dart';
import 'package:save_websites_with_hive/src/models/website.dart';

class Boxes {
  // TODO 13 : get 'websites' box
  static Box<Website> getWebsites() => Hive.box<Website>('websites');
}
