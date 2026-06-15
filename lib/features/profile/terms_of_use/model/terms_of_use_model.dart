import 'package:locals/shared/model/legal_document_section.dart';

class TermsOfUseModel {
  final String lastUpdated;
  final List<LegalDocumentSection> sections;

  const TermsOfUseModel({
    this.lastUpdated = 'June 15, 2026',
    this.sections = const [
      LegalDocumentSection(
        title: '1. Acceptance of Terms',
        paragraphs: [
          'By accessing or using Locals, you agree to be bound by these Terms of Use. If you do not agree, please do not use the app.',
        ],
      ),
      LegalDocumentSection(
        title: '2. Using the App',
        paragraphs: [
          'Locals helps you discover places, check in at locations, join events, and connect with other users in your city.',
          'You agree to use the app only for lawful purposes and in a way that does not harm other users or the service.',
        ],
      ),
      LegalDocumentSection(
        title: '3. Your Account',
        paragraphs: [
          'You are responsible for keeping your login credentials secure and for all activity under your account.',
          'You must provide accurate profile information and update it when it changes.',
        ],
      ),
      LegalDocumentSection(
        title: '4. Content & Conduct',
        paragraphs: [
          'You retain ownership of content you share, but grant Locals a license to display it within the app as needed to operate the service.',
          'Do not post offensive, misleading, or illegal content. We may remove content or suspend accounts that violate these terms.',
        ],
      ),
      LegalDocumentSection(
        title: '5. Subscriptions & Payments',
        paragraphs: [
          'Some features may require a paid subscription. Billing terms, renewal, and cancellation options are shown in Manage Subscription.',
          'Fees are non-refundable except where required by applicable law.',
        ],
      ),
      LegalDocumentSection(
        title: '6. Limitation of Liability',
        paragraphs: [
          'Locals is provided "as is" without warranties. We are not liable for indirect damages arising from your use of the app.',
          'For support, contact support@local.app.',
        ],
      ),
    ],
  });
}
