import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import 'custom_dialogue_card.dart';

Future<void> saveFile(List<int> bytes, String fileName, var context) async {
  final file = File('/storage/emulated/0/$fileName');
  file.writeAsBytesSync(bytes);
  errorDialogueCard(context: context, msg: "Effectué", title: "Effectué");
  // OpenFile.open('/storage/emulated/0/$fileName');
}

Future<void> saveCSVFile(String csv, String fileName, var context) async {
  final file = File('/storage/emulated/0/$fileName');
  await file.writeAsString(csv);
  errorDialogueCard(context: context, msg: "Effectué", title: "Effectué");
  // OpenFile.open('/storage/emulated/0/$fileName');
}

Future<String> createFolder() async {
  String folderName = "Henibe Network";
  final path = Directory("storage/emulated/0/$folderName");
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    return path.path;
  } else {
    path.create();
    return path.path;
  }
}
