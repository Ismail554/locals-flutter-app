import 'package:flutter/material.dart';
import 'package:locals/core/localization/l10n_extensions.dart';
import '../model/help_support_model.dart';
import '../repository/help_support_repository.dart';

class HelpSupportController extends ChangeNotifier {
  final HelpSupportRepository repo;
  HelpSupportModel state = const HelpSupportModel();

  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  bool isSending = false;

  HelpSupportController(this.repo);

  Future<void> load() async {
    state = await repo.load();
    subjectController.text = state.defaultSubject;
    notifyListeners();
  }

  Future<void> sendEmail(BuildContext context) async {
    final subject = subjectController.text.trim();
    final message = messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.helpWriteMessage)),
      );
      return;
    }

    if (isSending) return;
    isSending = true;
    notifyListeners();

    final success = await repo.sendSupportEmail(
      subject: subject.isEmpty ? state.defaultSubject : subject,
      message: message,
    );

    isSending = false;
    notifyListeners();

    if (!context.mounted) return;

    if (success) {
      messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(
          // context.l10n.helpMessageSent
          "Message sent successful!"
        )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send message. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }
}