import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_attendance/global/extentions/extentions.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.textEditingController,
      this.label,
      this.onChanged,
      required this.hintText,
      this.validator,
      this.textInputFormatter,this.keyboardType,this.onTap,this.readOnly=false,this.maxLines});

  final TextEditingController textEditingController;
  final String? label;
  void Function(String)? onChanged;
  final String hintText;
  final String? Function(String?)? validator;
  List<TextInputFormatter>? textInputFormatter;
  TextInputType? keyboardType;
  void Function()? onTap;
  bool readOnly;
  int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          SizedBox(
            height: 0.5.height,
          ),
          Container(
            margin: EdgeInsets.only(left: 0.35.height),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(
            height: 0.5.height,
          ),
        ],
        TextFormField(
           maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,

          controller: textEditingController,
          onChanged: onChanged,
          inputFormatters: textInputFormatter, // Only allow numbers

          decoration: InputDecoration(

            hintText: hintText,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
