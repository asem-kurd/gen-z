import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;

  const InputField({
    required this.hintText,
    required this.onSaved,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const CreateAccountButton({
    required this.formKey,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(250, 60),
        backgroundColor: Colors.grey.shade800,
      ),
      onPressed: onPressed,
      child: const Text(
        "Create Organization Account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
