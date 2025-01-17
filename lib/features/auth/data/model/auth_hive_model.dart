import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutorme/app/constants/hive_table_constant.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String password;
   
  UserHiveModel({
    String? id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  }): id= id?? const Uuid().v4();

// Initial Constructor:
const UserHiveModel.initial()
      : id ='',
      fullName='',
      email='',
      phone='',
      password='';

// From Entity as JSON
factory UserHiveModel.fromJson(Map<String, dynamic> json){
  return UserHiveModel(
    id:json['id'] as String?,
    fullName: json['fullName'] as String, 
    email: json['email'] as String,
    phone: json['phone'] as String, 
    password: json['password'] as String,
    );
}

// To Entity as Json
Map<String, dynamic> toJson(){
  return{
    'id':id,
    'fullName':fullName,
    'email':email,
    'phone':phone,
    'password':password,
  };
}
@override
List<Object?>get props=>[id,fullName,email,phone,password];
}

