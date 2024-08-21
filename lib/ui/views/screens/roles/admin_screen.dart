import 'package:flutter/material.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';

class StudentScreen extends StatelessWidget {
  GeneralUserInfoModel generalUserInfoModel;
  StudentScreen({super.key, required this.generalUserInfoModel});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Admin'),
        ],
      ),
    );
  }
}
