import 'package:clnapp/utils/app_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_setting.dart';

class DirectoryPicker {
  static Future<String> pickDir() async {
    final setting = AppProvider().get<Setting>();
    String? path = await FilePicker.platform.getDirectoryPath();
    setting.path = path ?? "No path found";
    return setting.path!;
  }
}