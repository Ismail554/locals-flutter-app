import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/components/profile_screen_header.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/find_locals_controller.dart';
import '../model/find_locals_args.dart';
import '../repository/find_locals_repository.dart';
import 'widgets/find_local_card.dart';

class FindLocalsScreen extends StatelessWidget {
  final FindLocalsArgs args;

  const FindLocalsScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FindLocalsController(FindLocalsRepositoryImpl(), args),
      child: const _FindLocalsView(),
    );
  }
}

class _FindLocalsView extends StatelessWidget {
  const _FindLocalsView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FindLocalsController>();
    final users = controller.state.users;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
              child: ProfileScreenHeader(
                title: 'Find Locals',
                onBack: () => context.pop(),
              ),
            ),
            SizedBox(height: 20.h),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 0.86,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final story = controller.storyForUser(user.id);

                  return Align(
                    alignment: Alignment.topCenter,
                    child: FindLocalCard(
                      user: user,
                      story: story,
                      onCardTap: () => controller.openProfile(context),
                      onAvatarTap: () =>
                          controller.openUserStory(context, user.id),
                      onFollowTap: () => controller.toggleFollow(user.id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
