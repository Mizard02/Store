import 'package:flutter/material.dart';

import '../models/User.dart';


class UserModificationPage extends StatefulWidget {

  UserModificationPage({Key? key}) : super(key: key);

  @override
  _UserModificationPageState createState() => _UserModificationPageState();
}

class _UserModificationPageState extends State<UserModificationPage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modification data'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  labelText: 'Surname',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFD1C4E9),
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                   // if (_formKey.currentState!.validate())
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Modify",
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