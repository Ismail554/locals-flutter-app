import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/manage_subscription_controller.dart';
import '../repository/manage_subscription_repository.dart';
import 'widgets/subscription_billing_section.dart';
import 'widgets/subscription_payment_card.dart';
import 'widgets/subscription_plan_card.dart';
import 'widgets/subscription_settings_card.dart';

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ManageSubscriptionController(ManageSubscriptionRepositoryImpl()),
      child: const _ManageSubscriptionView(),
    );
  }
}

class _ManageSubscriptionView extends StatelessWidget {
  const _ManageSubscriptionView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ManageSubscriptionController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Manage Subscription',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                children: [
                  SubscriptionPlanCard(
                    planName: state.planName,
                    renewalText: state.renewalText,
                    price: state.price,
                  ),
                  SizedBox(height: 16.h),
                  SubscriptionSettingsCard(
                    autoRenew: state.autoRenew,
                    onAutoRenewChanged: controller.setAutoRenew,
                  ),
                  SizedBox(height: 16.h),
                  SubscriptionPaymentCard(
                    paymentMethod: state.paymentMethod,
                    paymentExpiry: state.paymentExpiry,
                  ),
                  SizedBox(height: 24.h),
                  SubscriptionBillingSection(items: state.billingHistory),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
