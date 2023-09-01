import 'package:flutter/material.dart';
import 'package:flutter_application_1/restManagers/HttpRequest.dart';

import '../models/User.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _registerUser() async {
    User u = User(name: _nameController.value.text, surname: _surnameController.value.text, address: _addressController.value.text, email: _emailController.value.text, phoneNumber: _phoneNumberController.value.text);
    Model.sharedInstance.registerUser(u, _passwordController.value.text);

    _nameController.clear();
    _surnameController.clear();
    _addressController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Action to display additional information
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildInputField(
                  labelText: 'Name',
                  controller: _nameController,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 16.0),
                _buildInputField(
                  labelText: 'Last Name',
                  controller: _surnameController,
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 16.0),
                _buildInputField(
                  labelText: 'Address',
                  controller: _addressController,
                  prefixIcon: Icon(Icons.home),
                ),
                SizedBox(height: 16.0),
                _buildInputField(
                  labelText: 'Email',
                  controller: _emailController,
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(height: 16.0),
                _buildInputField(
                  labelText: 'Phone Number',
                  controller: _phoneNumberController,
                  prefixIcon: Icon(Icons.phone),
                ),
                SizedBox(height: 16.0),
                _buildInputField(
                  labelText: 'Password',
                  controller: _passwordController,
                  prefixIcon: Icon(Icons.lock),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) _registerUser();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    required Icon prefixIcon,
  }) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter $labelText";
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
      ),
    );
  }
}