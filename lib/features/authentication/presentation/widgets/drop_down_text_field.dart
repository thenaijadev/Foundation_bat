import 'package:batnf/universal.dart/text_widget.dart';
import 'package:batnf/utilities/lists.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class DropDownInput extends StatefulWidget {
  const DropDownInput({super.key, this.onChanged});
  final void Function(dynamic)? onChanged;
  @override
  State<DropDownInput> createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  late SingleValueDropDownController _cnt;
  late MultiValueDropDownController _cntMulti;

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    _cntMulti = MultiValueDropDownController();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    _cntMulti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          text: "Location",
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 5,
        ),
        DropDownTextField(
          // initialValue: "name4",
          controller: _cnt,
          clearOption: true,
          enableSearch: true,
          // dropdownColor: Colors.green,
          textFieldDecoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          searchDecoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          validator: (value) {
            if (value == null || value == "" || value.isEmpty) {
              return "Required field";
            } else {
              return null;
            }
          },
          dropDownItemCount: 6,
          dropDownList: states(),
          onChanged: widget.onChanged,
        )
      ],
    );
  }
}
