import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tutorme/app/constants/hive_table_constant.dart';
import 'package:tutorme/features/auth/data/model/auth_hive_model.dart';
import 'package:tutorme/features/tutors/data/model/tutor_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path='${directory.path}/tutorme.db';
    Hive.init(path);
    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(TutorHiveModelAdapter());
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

// Tutor specific methods
  Future<void> addTutor(TutorHiveModel tutor) async {
    var box = await Hive.openBox<TutorHiveModel>(HiveTableConstant.tutorBox);
    await box.put(tutor.username, tutor);  // Using username as key
  }

  Future<List<TutorHiveModel>> getAllTutors() async {
    var box = await Hive.openBox<TutorHiveModel>(HiveTableConstant.tutorBox);
    return box.values.toList();
  }

  Future<TutorHiveModel?> getTutorByUsername(String username) async {
    var box = await Hive.openBox<TutorHiveModel>(HiveTableConstant.tutorBox);
    return box.get(username);
  }

  Future<void> clearTutors() async {
    var box = await Hive.openBox<TutorHiveModel>(HiveTableConstant.tutorBox);
    await box.clear();
  }


  Future<void> close() async {
    await Hive.close();
  }
}
