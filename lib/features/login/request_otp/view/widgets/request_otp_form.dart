import 'package:flutter/material.dart';
import 'package:locals/shared/components/auth_text_field.dart';
import 'package:locals/core/localization/l10n_extensions.dart';


class RequestOtpForm extends StatelessWidget {
  final ValueChanged<String> onEmailChanged;

  const RequestOtpForm({super.key, required this.onEmailChanged});

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      label: context.l10n.authEmailLabel,
      hint: context.l10n.authEmailHint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      onChanged: onEmailChanged,
    );
  }
}