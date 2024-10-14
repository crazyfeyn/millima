import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';

class TeacherScreen extends StatelessWidget {
  GeneralUserInfoModel generalUserInfoModel;
  TeacherScreen({super.key, required this.generalUserInfoModel});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Teacher'),
      ),
    );
  }
}
