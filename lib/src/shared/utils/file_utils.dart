import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<ImageFile> imageFileFromImageUrl(String path, String name) async {
  final response = await http.get(Uri.parse(path));

      final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, name));

  file.writeAsBytesSync(response.bodyBytes);
  final xFile  = XFile(file.path);

  return convertXFileToImageFile(xFile);
}

