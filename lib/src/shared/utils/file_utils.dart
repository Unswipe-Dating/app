import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../presentation/widgets/multi_image_view/image_file.dart';
import '../presentation/widgets/multi_image_view/picker_extension.dart';

Future<ImageFile> imageFileFromImageUrl(String path, String name) async {
  final response = await http.get(Uri.parse(path));

      final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, name));

  file.writeAsBytesSync(response.bodyBytes);
  final xFile  = XFile(file.path);

  return convertXFileToImageFile(xFile);
}

