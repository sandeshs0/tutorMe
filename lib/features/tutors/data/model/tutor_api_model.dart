
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tutorme/features/tutors/domain/entity/tutor_entity.dart';

part 'tutor_api_model.g.dart';

@JsonSerializable()
class TutorApiModel extends Equatable{
  @JsonKey(name:'_id')
  final String? tutorId;
  final String name;
  final String email;
  // final String username;
  final String profileImage;
  final String bio;
  final double hourlyRate;
  final String description;
  final double rating;
  final List<String> subjects;

  const TutorApiModel({
    this.tutorId,
    required this.name,
    required this.email,
    required this.bio,
    required this.description,
    required this.hourlyRate,
    required this.profileImage,
    // required this.username,
    required this.rating,
    required this.subjects,
  });

  // From JSON
  factory TutorApiModel.fromJson(Map<String, dynamic>json)=>
      _$TutorApiModelFromJson(json);

  // To JSon
    Map<String, dynamic> toJson() => _$TutorApiModelToJson(this);


// Convert to Domain Entity
TutorEntity toEntity(){
  return TutorEntity(
    tutorId: tutorId,
    name: name, 
  email: email, 
  bio: bio, 
  description: description, 
  hourlyRate: hourlyRate, 
  profileImage: profileImage, 
  rating: rating, 
  subjects: subjects,
  //  username: username,
   );
}

// Creating API Model from Domain Entiry

factory TutorApiModel.fromEntity(TutorEntity entity){
  return TutorApiModel(
    tutorId: entity.tutorId,
    name: entity.name, 
  email: entity.email, 
  bio: entity.bio, 
  description: entity.description, 
  hourlyRate: entity.hourlyRate,
   profileImage: entity.profileImage, 
  //  username: entity.username, 
   rating: entity.rating, 
   subjects: entity.subjects,
   );
}

  @override
  // TODO: implement props
  List<Object?> get props => [
    tutorId,
    name,
    email,
    // username,
    bio,
    description,
    hourlyRate,
    rating,
    subjects,
    profileImage,
  ];
}
