import 'package:flutter/material.dart';

class DataInputView extends StatelessWidget {
  const DataInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            SizedBox(height: 10),
            renderTextFormField(label: "학과", onSaved: (val) {}, validator: (val) {}),
            renderTextFormField(label: "학과", onSaved: (val) {}, validator: (val) {}),
          ],
        ),
      ),
    );
  }

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    assert(onSaved != null);
    assert(validator != null);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter your email',
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }
}