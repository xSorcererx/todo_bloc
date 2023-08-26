import 'package:flutter/material.dart';
import 'package:todo_bloc/presentation/utils/size_constants.dart';

// custom text field
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.maxLines,
    required this.textEditingController,
  });
  final String title;
  final String hintText;
  final int maxLines;
  final TextEditingController textEditingController;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
        ),
        SBC.lH,
        Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: widget.hintText,
            ),
            maxLines: widget.maxLines,
          ),
        ),
      ],
    );
  }
}
