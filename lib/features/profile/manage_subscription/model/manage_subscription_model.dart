class BillingHistoryItem {
  final String title;
  final String subtitle;
  final String amount;

  const BillingHistoryItem({
    required this.title,
    required this.subtitle,
    required this.amount,
  });
}

class ManageSubscriptionModel {
  final String planName;
  final String renewalText;
  final String price;
  final bool autoRenew;
  final String paymentMethod;
  final String paymentExpiry;
  final List<BillingHistoryItem> billingHistory;

  const ManageSubscriptionModel({
    this.planName = 'Pro • Monthly',
    this.renewalText = 'Renews on May 14, 2026',
    this.price = '\$9.99',
    this.autoRenew = true,
    this.paymentMethod = 'Visa •• 4821',
    this.paymentExpiry = 'Expires 09/28',
    this.billingHistory = const [
      BillingHistoryItem(
        title: 'Monthly',
        subtitle: 'Apr 14, 2026 · INV-204',
        amount: '\$9.99',
      ),
      BillingHistoryItem(
        title: 'Monthly',
        subtitle: 'Mar 14, 2026 · INV-203',
        amount: '\$9.99',
      ),
      BillingHistoryItem(
        title: 'Monthly',
        subtitle: 'Feb 14, 2026 · INV-202',
        amount: '\$9.99',
      ),
    ],
  });

  ManageSubscriptionModel copyWith({bool? autoRenew}) {
    return ManageSubscriptionModel(
      planName: planName,
      renewalText: renewalText,
      price: price,
      autoRenew: autoRenew ?? this.autoRenew,
      paymentMethod: paymentMethod,
      paymentExpiry: paymentExpiry,
      billingHistory: billingHistory,
    );
  }
}
