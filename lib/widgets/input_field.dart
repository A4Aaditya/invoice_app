import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller);
  }
}
