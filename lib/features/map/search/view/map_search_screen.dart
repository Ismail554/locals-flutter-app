import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:locals/shared/theme/app_colors.dart';
import '../controller/map_search_controller.dart';
import '../repository/map_search_repository.dart';
import 'widgets/map_search_section.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

class MapSearchScreen extends StatelessWidget {
  final String initialQuery;

  const MapSearchScreen({super.key, this.initialQuery = ''});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapSearchController(
        MapSearchRepositoryImpl(),
        initialQuery: initialQuery,
      ),
      child: _MapSearchView(initialQuery: initialQuery),
    );
  }
}

class _MapSearchView extends StatefulWidget {
  final String initialQuery;

  const _MapSearchView({required this.initialQuery});

  @override
  State<_MapSearchView> createState() => _MapSearchViewState();
}

class _MapSearchViewState extends State<_MapSearchView> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialQuery);
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MapSearchController>();
    final state = controller.state;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.chipUnselected,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        onChanged: controller.setQuery,
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            controller.selectSuggestion(context, value.trim());
                          }
                        },
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: context.l10n.mapSearchHint,
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.textSecondary,
                            size: 22.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.cancel(context),
                    child: Text(
                      context.l10n.commonCancel,
                      style: TextStyle(
                        color: AppColors.actionPink,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              if (state.recentSearches.isNotEmpty) ...[
                MapSearchSection(
                  icon: Icons.history,
                  title: context.l10n.mapSearchRecent,
                  items: state.recentSearches,
                  onItemTap: (value) =>
                      controller.selectSuggestion(context, value),
                ),
                SizedBox(height: 24.h),
              ],
              MapSearchSection(
                icon: Icons.trending_up,
                title: context.l10n.mapSearchTrending,
                items: state.trendingSearches,
                onItemTap: (value) =>
                    controller.selectSuggestion(context, value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
