import 'package:notes/View-model/State/form_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
   const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {


  @override
  Widget build(BuildContext context) {
    print('object');
    final formValidator = Provider.of<FormValidator>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: FormValidator.formKey,
                  child: Column(
                    children: [
                      InputTextField(
                        controller: FormValidator.emailController,
                        hintText: 'email',
                        validator: FormValidator.validateEmail,
                      ),
                      const SizedBox(height: 5,),
                      InputTextField(
                        controller: FormValidator.passwordController,
                        hintText: 'password',
                        validator: FormValidator.validatePassword,
                      ),
                      ElevatedButton(
                          onPressed: () => formValidator.submitForm(context),
                          child: const Text('login')),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    print('object3');
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
        hintText: hintText,
        enabledBorder:OutlineInputBorder(
          borderSide:  const BorderSide(
              width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:  const BorderSide(
              width: 2, color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),  // Error border
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),  // Focused error border
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: validator
    );
  }
}
