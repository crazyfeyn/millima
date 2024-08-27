import 'package:flutter/material.dart';
import 'package:flutter_application/ui/views/screens/drawer/group_screen.dart';
import 'package:flutter_application/ui/views/screens/drawer/room_screen.dart';
import 'package:flutter_application/ui/views/screens/drawer/subject_screen.dart';
import 'package:flutter_application/ui/views/screens/roles/all_admins_screen.dart';
import 'package:flutter_application/ui/views/screens/roles/all_student_screen.dart';
import 'package:flutter_application/ui/views/screens/roles/all_teacher_screen.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Admin Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllAdminsScreen())),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/admin.svg',
                height: 23,
              ),
              title: const Text('Admins'),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AllTeacherScreen(),
              ),
            ),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/teacher.svg',
                height: 23,
              ),
              title: const Text('Teachers'),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllStudentScreen())),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/student.svg',
                height: 23,
              ),
              title: const Text('Students'),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GroupScreen())),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/student.svg',
                height: 23,
              ),
              title: const Text('Groups'),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RoomScreen())),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/student.svg',
                height: 23,
              ),
              title: const Text('Rooms'),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubjectScreen(),
              ),
            ),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/student.svg',
                height: 23,
              ),
              title: const Text('Subjects'),
            ),
          ),
        ],
      ),
    );
  }
}
