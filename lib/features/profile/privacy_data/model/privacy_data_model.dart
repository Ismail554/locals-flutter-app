class PrivacyDataModel {
  final String encryptionTitle;
  final String encryptionSubtitle;
  final String privacyPolicyUrl;
  final String termsOfUseUrl;

  const PrivacyDataModel({
    this.encryptionTitle = 'Your data is encrypted',
    this.encryptionSubtitle =
        'Health information is stored locally and synced securely.',
    this.privacyPolicyUrl = 'https://local.app/privacy',
    this.termsOfUseUrl = 'https://local.app/terms',
  });
}
