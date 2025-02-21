import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorme/features/student/data/dto/update_student_profile_dto.dart';
import 'package:tutorme/features/student/domain/entity/student_entity.dart';
import 'package:tutorme/features/student/presentation/view_model/bloc/student_profile_bloc.dart';

class EditStudentProfileView extends StatefulWidget {
  final StudentEntity student;

  const EditStudentProfileView({super.key, required this.student});

  @override
  _EditStudentProfileViewState createState() => _EditStudentProfileViewState();
}

class _EditStudentProfileViewState extends State<EditStudentProfileView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController,
      _emailController,
      _phoneController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.student.name);
    _emailController = TextEditingController(text: widget.student.email);
    _phoneController = TextEditingController(text: widget.student.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name")),
              TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email")),
              TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: "Phone")),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<StudentProfileBloc>().add(UpdateStudentProfile(
                        updatedData: UpdateStudentProfileDTO(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                        ),
                      ));
                  Navigator.pop(context);
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
