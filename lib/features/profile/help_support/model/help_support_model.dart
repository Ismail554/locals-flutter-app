class HelpSupportModel {
  final String supportEmail;
  final String defaultSubject;
  final String appVersion;

  const HelpSupportModel({
    this.supportEmail = 'support@local.app',
    this.defaultSubject = 'Help & Support request',
    this.appVersion = '1.0.0',
  });
}
