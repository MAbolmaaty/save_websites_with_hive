// TODO 6 : Create Hive Model

import 'package:hive/hive.dart';

part 'website.g.dart';

@HiveType(typeId: 0)
class Website extends HiveObject {
  @HiveField(0)
  late String websiteName;

  @HiveField(1)
  late String websiteUrl;
}


// TODO 7 : Generate Model Adapter
/// open terminal from root folder of your flutter project
/// run command : $ flutter packages pub run build_runner build  