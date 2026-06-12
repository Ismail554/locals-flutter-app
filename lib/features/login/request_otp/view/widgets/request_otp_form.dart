import 'package:flutter/material.dart';
import 'package:locals/shared/components/auth_text_field.dart';

class RequestOtpForm extends StatelessWidget {
  final ValueChanged<String> onEmailChanged;

  const RequestOtpForm({super.key, required this.onEmailChanged});

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: 'Email',
      hint: 'you@gmail.com',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      onChanged: onEmailChanged,
    );
  }
}
