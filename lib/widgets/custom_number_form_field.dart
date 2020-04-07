
import 'package:flutter/material.dart';

class CustomNumberFormField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final String suffix;
  final bool decimal;
  final ValueChanged<bool> onChanged;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;

  CustomNumberFormField({
    this.labelText,
    this.suffix,
    this.decimal = false,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          suffixText: suffix,
        ),
        autocorrect: false,
        initialValue: initialValue,
        onChanged: (newValue) => onChanged?.call(newValue.isNotEmpty),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}