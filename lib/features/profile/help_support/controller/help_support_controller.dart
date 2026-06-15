import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
        const SnackBar(content: Text('Please write a message')),
      );
      return;
    }

    if (isSending) return;
    isSending = true;
    notifyListeners();

    final uri = Uri(
      scheme: 'mailto',
      path: state.supportEmail,
      query: _encodeQuery({
        'subject': subject.isEmpty ? state.defaultSubject : subject,
        'body': message,
      }),
    );

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (launched) {
      await repo.sendSupportEmail(subject: subject, message: message);
    }

    isSending = false;
    notifyListeners();

    if (!context.mounted) return;

    if (launched) {
      messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening email app')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email app')),
      );
    }
  }

  String? _encodeQuery(Map<String, String> params) {
    return params.entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}',
        )
        .join('&');
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
