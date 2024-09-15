import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormValidator with ChangeNotifier {
  static final formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  List<Map<String,dynamic>> userCredentialsList = [];

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'enter valid email id';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter password';
    } else if (value.length <= 8) {
      return 'enter password of 8 characters';
    }
    return null;
  }

  static String? validatePhoneNum(String? value) {
    if (value == null || value.isEmpty) {
      return 'enter Phone number';
    } else if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'enter a valid phone number';
    }
    return null;
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      debugPrint('Email: ${emailController.text}');
      debugPrint('Password: ${passwordController.text}');

      Map<String, dynamic> userCred = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      userCredentialsList.add(userCred);

      emailController.clear();
      passwordController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
