import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorme/features/auth/data/model/auth_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path='${directory.path}/tutorme.db';
    Hive.init(path);
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  Future<void> addItem<T>(String boxName, String key, T item) async {
    var box = await Hive.openBox<T>(boxName);
    await box.put(key, item);
  }

  Future<List<T>> getAllItems<T>(String boxName) async {
    var box = await Hive.openBox<T>(boxName);
    return box.values.toList();
  }

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

    //login
  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>('userBox');
    try {
      return box.values.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null; 
    }
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk('userBox');
  }

  Future<void> close() async {
    await Hive.close();
  }
}
