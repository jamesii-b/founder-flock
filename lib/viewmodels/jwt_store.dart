import 'dart:io';

import 'package:path_provider/path_provider.dart';

class JwtStorage {
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/jwt.txt');
  }

  Future<String?> readJwt() async {
    try {
      final file = await _getFile();
      String jwt = await file.readAsString();
      return jwt;
    } catch (e) {
      print("Error reading JWT: $e");
      return null;
    }
  }

  Future<void> writeJwt(String jwt) async {
    final file = await _getFile();
    await file.writeAsString(jwt);
  }
}
