import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_events.dart';
import 'package:flutter_application/logic/blocs/home_bloc/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application/data/models/general_user_info_model.dart';

class ProfileWidget extends StatefulWidget {
  final GeneralUserInfoModel generalUserInfoModel;

  const ProfileWidget({super.key, required this.generalUserInfoModel});

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  String? _photoPath;

  @override
  void initState() {
    super.initState();

    final userInfo = widget.generalUserInfoModel;

    _nameController = TextEditingController(text: userInfo.name);
    _phoneController = TextEditingController(text: userInfo.phone);
    _emailController = TextEditingController(text: userInfo.email);
    _photoPath = userInfo.photo;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updatePhoto(File newPath) {
    setState(() {
      _photoPath = newPath.path;
    });
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _updatePhoto(File(image.path));
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.generalUserInfoModel.name = _nameController.text;
      widget.generalUserInfoModel.phone = _phoneController.text;
      widget.generalUserInfoModel.email = _emailController.text;
      widget.generalUserInfoModel.photo = _photoPath;

      context
          .read<HomeBloc>()
          .add(HomeUserUpdated(widget.generalUserInfoModel));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User info updated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User Info'),
      ),
      body: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeErrorState) {
            return Center(
              child: Text(state.error),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Choose one'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickImage(context, ImageSource.camera);
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _pickImage(context, ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.photo_library),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      child: _photoPath != null && _photoPath!.isNotEmpty
                          ? Container(
                              clipBehavior: Clip.hardEdge,
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: _photoPath!.contains(
                                      'http://millima.flutterwithakmaljon.uz//storage/avatars/')
                                  ? Image.network(_photoPath!,
                                      fit: BoxFit.cover)
                                  : Image.file(
                                      File(_photoPath!),
                                      fit: BoxFit.cover,
                                    ),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              child: Icon(Icons.person, size: 50),
                            ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: submitForm,
                        child: const Text('Update Info'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
