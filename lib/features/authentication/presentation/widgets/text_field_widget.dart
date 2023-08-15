import 'package:batnf/universal.dart/text_widget.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.label,
      this.obscureText = false,
      this.showVisibility = false,
      this.toggleVisibility,
      this.validator,
      this.onChanged,
      required this.fieldKey});
  final TextEditingController controller;
  final bool obscureText;
  final bool showVisibility;
  final String label;
  final void Function()? toggleVisibility;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final GlobalKey<FormFieldState> fieldKey;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: widget.label,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          key: widget.fieldKey,
          onChanged: widget.onChanged,
          cursorColor: Colors.black,
          controller: widget.controller,
          obscureText: widget.obscureText,
          obscuringCharacter: "*",
          validator: widget.validator,
          decoration: InputDecoration(
            suffix: widget.showVisibility
                ? GestureDetector(
                    onTap: widget.toggleVisibility,
                    child:
                        TextWidget(text: widget.obscureText ? "Show" : "Hide"))
                : const Text(""),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        )
      ],
    );
  }
}
