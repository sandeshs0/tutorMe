import 'package:path_provider/path_provider.dart';

class LocalNetwork {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
  }
}
