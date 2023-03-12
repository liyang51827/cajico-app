import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

/// 利用する場合は以下を記載
/// import 'package:lispo_app/util/xfile_extension.dart';
extension XfileExtension on XFile {
  Future<http.MultipartFile> toMultiPartFileField({
    required String filename,
    required String fieldName,
  }) async {
    final ext = name.split('.').last;
    return http.MultipartFile.fromPath(
      fieldName,
      path,
      filename: '$filename.$ext',
      contentType: mimeType != null ? MediaType.parse(mimeType!) : null,
    );
  }
}
