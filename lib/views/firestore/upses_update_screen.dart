import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersUpdateScreen extends StatefulWidget {
  final String? docId;
  final String? name;
  final String? email;
  final int? phone;
  final int? age;
  final String? vill;
  final int? pinCode;
  final String? post;

  const UsersUpdateScreen({
    Key? key,
    this.docId,
    this.name,
    this.email,
    this.phone,
    this.age,
    this.vill,
    this.pinCode,
    this.post,

  }) : super(key: key);

  @override
  _UsersUpdateScreenState createState() => _UsersUpdateScreenState();
}

class _UsersUpdateScreenState extends State<UsersUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController villController;
  late TextEditingController pinCodeController;
  late TextEditingController postController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone?.toString() ?? '');
    ageController = TextEditingController(text: widget.age?.toString() ?? '');
    villController = TextEditingController(text: widget.vill);
    pinCodeController = TextEditingController(text: widget.pinCode?.toString() ?? '');
    postController = TextEditingController(text: widget.post);
  }


  void updateStudentData() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection("users_data").doc(widget.docId).update({
        "name": nameController.text,
        "email": emailController.text,
        "phone": int.tryParse(phoneController.text) ?? widget.phone,
        "age": int.tryParse(ageController.text) ?? widget.age,
        "address": {
          "vill": villController.text,
          "pinCode": int.tryParse(pinCodeController.text) ?? widget.pinCode,
          "post": postController.text,
        },
      });
      Navigator.pop(context);
    }
  }


  Widget _buildTextField({required String label, required TextEditingController controller, TextInputType keyboardType = TextInputType.text,}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),labelText: label),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Update Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(label: 'Name', controller: nameController),
              _buildTextField(label: 'Email', controller: emailController),
              _buildTextField(label: 'Phone', controller: phoneController, keyboardType: TextInputType.number),
              _buildTextField(label: 'Age', controller: ageController, keyboardType: TextInputType.number),
              _buildTextField(label: 'Vill', controller: villController),
              _buildTextField(label: 'PinCode', controller: pinCodeController, keyboardType: TextInputType.number),
              _buildTextField(label: 'Post', controller: postController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateStudentData,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}