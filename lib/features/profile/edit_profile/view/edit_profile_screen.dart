import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/primary_button.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/edit_profile_controller.dart';
import '../repository/edit_profile_repository.dart';
import 'widgets/edit_profile_avatar_section.dart';
import 'widgets/edit_profile_form_field.dart';
import 'widgets/edit_profile_password_section.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileController(EditProfileRepositoryImpl())..load(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditProfileController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: context.l10n.editProfileTitle,
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: controller.state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                      children: [
                        EditProfileAvatarSection(
                          avatarColor: controller.state.avatarColor,
                          avatarImagePath: controller.state.avatarImagePath,
                          avatarUrl: controller.state.avatarUrl,
                          isLoading: controller.isPickingPhoto,
                          onChangePhoto: () => controller.changePhoto(context),
                        ),
                        SizedBox(height: 28.h),
                        EditProfileFormField(
                          label: context.l10n.editProfileName,
                          controller: controller.nameController,
                        ),
                        SizedBox(height: 16.h),
                        EditProfileFormField(
                          label: context.l10n.authEmailLabel,
                          controller: controller.emailController,
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16.h),
                        EditProfileFormField(
                          label: context.l10n.editProfileLocation,
                          controller: controller.locationController,
                        ),
                        SizedBox(height: 24.h),
                        PrimaryButton(
                          label: context.l10n.editProfileSaveChanges,
                          onPressed: () {
                            if (!controller.isSaving) controller.saveChanges(context);
                          },
                        ),
                        SizedBox(height: 32.h),
                        EditProfilePasswordSection(
                          currentPasswordController:
                              controller.currentPasswordController,
                          newPasswordController:
                              controller.newPasswordController,
                          confirmPasswordController:
                              controller.confirmPasswordController,
                          obscureCurrentPassword:
                              controller.obscureCurrentPassword,
                          obscureNewPassword: controller.obscureNewPassword,
                          obscureConfirmPassword:
                              controller.obscureConfirmPassword,
                          onToggleCurrentPassword:
                              controller.toggleCurrentPasswordVisibility,
                          onToggleNewPassword:
                              controller.toggleNewPasswordVisibility,
                          onToggleConfirmPassword:
                              controller.toggleConfirmPasswordVisibility,
                          onChangePassword: () =>
                              controller.changePassword(context),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}