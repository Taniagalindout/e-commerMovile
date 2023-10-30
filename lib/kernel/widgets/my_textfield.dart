import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String title;
  final String errorText;
  final String validations;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.title,
    required this.errorText,
    required this.validations,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(children: [
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText ? _obscureText : false,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          validator: (value) {
            RegExp regex = RegExp(widget.validations);
            if (value == null || value.isEmpty) {
              return 'Campo obligatorio';
            } else if (!regex.hasMatch(value)) {
              return widget.errorText;
            }
            return null;
          },
        ),
      ]),
    );
  }
}
