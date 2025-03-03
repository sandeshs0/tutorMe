// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorApiModel _$TutorApiModelFromJson(Map<String, dynamic> json) =>
    TutorApiModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      description: json['description'] as String,
      hourlyRate: (json['hourlyRate'] as num).toDouble(),
      profileImage: json['profileImage'] as String,
      username: json['username'] as String,
      rating: (json['rating'] as num).toDouble(),
      subjects:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TutorApiModelToJson(TutorApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'profileImage': instance.profileImage,
      'bio': instance.bio,
      'hourlyRate': instance.hourlyRate,
      'description': instance.description,
      'rating': instance.rating,
      'subjects': instance.subjects,
    };
