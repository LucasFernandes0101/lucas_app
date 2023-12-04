import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key});

  @override
  State<StatefulWidget> createState() {
    return FormularioState();
  }
}

class FormularioState extends State<Formulario> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  void loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _cpfController.text = prefs.getString('cpf') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _dobController.text = prefs.getString('dob') ?? '';
      String imagePath = prefs.getString('imagePath') ?? '';
      if (imagePath.isNotEmpty) {
        _image = File(imagePath);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('cpf', _cpfController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('phone', _phoneController.text);
    prefs.setString('dob', _dobController.text);
    if (_image != null) {
      prefs.setString('imagePath', _image!.path);
    }
    _toggleEditing(false);
  }

  Future<void> sendEmail() async {
    final email = _emailController.text;
    final subject = 'Assunto';
    final body = 'Corpo do e-mail';

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': subject, 'body': body},
    );

    try {
      await launch(emailLaunchUri.toString());
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Color(0xff7422ad),
        actions: [
          IconButton(
            icon: Icon(Icons.email),
            onPressed: sendEmail,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed:
                _isEditing ? saveProfileData : () => _toggleEditing(true),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Container(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.photo_camera),
                                title: Text('Câmera'),
                                onTap: () {
                                  getImageFromCamera();
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Galeria'),
                                onTap: () {
                                  getImageFromGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xff7422ad),
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child:
                      _image == null ? Icon(Icons.camera_alt, size: 50) : null,
                ),
              ),
              _buildEditableTextField(
                  _nameController, 'Seu nome', Icons.person),
              SizedBox(height: 15),
              _buildEditableTextField(_cpfController, 'CPF', Icons.article),
              SizedBox(height: 15),
              _buildEditableTextField(
                  _phoneController, 'Telefone', Icons.phone),
              SizedBox(height: 15),
              _buildEditableTextField(_emailController, 'E-mail', Icons.email),
              SizedBox(height: 15),
              _buildEditableTextField(
                  _dobController, 'Data de Nascimento', Icons.calendar_today),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableTextField(
      TextEditingController controller, String hintText, IconData prefixIcon) {
    return TextField(
      enabled: _isEditing,
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }

  void _toggleEditing(bool status) {
    setState(() {
      _isEditing = status;
    });
  }
}
