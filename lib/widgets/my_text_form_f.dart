import 'package:flutter/material.dart';

class MyTextFormF extends StatefulWidget {
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final IconData? icon;
  final String? hintText;
  final String? Function(String?)? validation;

  const MyTextFormF({
    Key? key,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.icon = Icons.text_fields,
    this.hintText,
    this.validation,
  }) : super(key: key);

  @override
  State<MyTextFormF> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<MyTextFormF> {
  bool? _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return TextFormField(
          obscureText: _obscureText!,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText ?? '',
            fillColor: Colors.grey[200],
            prefixIcon: Icon(widget.icon ??
                (widget.isPassword ? Icons.lock : Icons.text_fields)),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText! ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText!;
                      });
                    },
                  )
                : null,
          ),
          validator: widget.validation,
        );
      },
    );
  }
}
