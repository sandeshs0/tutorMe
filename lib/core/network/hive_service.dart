import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorme/features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path='${directory.path}/tutorme.db';
    Hive.init(path);
    // Register Adapters
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  // User Queries
  // Register
  Future<void> addUser(UserHiveModel user)async{
    var box = await Hive.openBox<UserHiveModel>('userBox');
    await box.put(user.id, user);
  }

  // Delete a User
   Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    await box.delete(id);
  }

  // get all
    Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    return box.values.toList();
  }

    // Find User by Email and Password (Login)
  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    try {
      return box.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null; // Return null if no user is found
    }
  }

  
  // Clear All Data
  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  // Clear Specific User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  // Close Hive Database
  Future<void> close() async {
    await Hive.close();
  }
}
