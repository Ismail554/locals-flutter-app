import 'package:locals/shared/model/legal_document_section.dart';

class PrivacyPolicyModel {
  final String lastUpdated;
  final List<LegalDocumentSection> sections;

  const PrivacyPolicyModel({
    this.lastUpdated = 'June 15, 2026',
    this.sections = const [
      LegalDocumentSection(
        title: '1. Introduction',
        paragraphs: [
          'Welcome to Locals. We respect your privacy and are committed to protecting your personal data. This policy explains how we collect, use, and safeguard your information when you use our app.',
        ],
      ),
      LegalDocumentSection(
        title: '2. Information We Collect',
        paragraphs: [
          'We may collect information you provide directly, such as your name, email address, profile photo, and location check-ins.',
          'We also collect usage data including app interactions, device information, and approximate location to improve your experience.',
        ],
      ),
      LegalDocumentSection(
        title: '3. How We Use Your Data',
        paragraphs: [
          'Your data helps us personalize recommendations, track visits and points, display your profile to other users based on your privacy settings, and keep the app secure.',
          'We do not sell your personal information to third parties.',
        ],
      ),
      LegalDocumentSection(
        title: '4. Data Storage & Security',
        paragraphs: [
          'Health and sensitive information is stored locally on your device when possible and synced securely to our servers using encryption.',
          'We implement industry-standard measures to protect your data from unauthorized access.',
        ],
      ),
      LegalDocumentSection(
        title: '5. Your Rights',
        paragraphs: [
          'You can access, update, or delete your account data at any time from Settings. You may also control who sees your profile, photos, and leaderboard visibility in Privacy settings.',
          'Contact us at support@local.app if you have questions about your data.',
        ],
      ),
    ],
  });
}
