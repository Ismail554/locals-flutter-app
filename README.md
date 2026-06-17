# Locals

A Flutter mobile app for discovering local places, checking in, completing missions, sharing stories, and competing on city leaderboards.

| Status | Detail |
|--------|--------|
| **Frontend** | Complete (UI + navigation + mock data) |
| **Backend** | Not integrated — ready for API wiring |
| **Platform** | iOS & Android |
| **Flutter SDK** | ^3.10.4 |

---

## Table of contents

1. [What is Locals?](#what-is-locals)
2. [Quick start](#quick-start)
3. [Project statistics](#project-statistics)
4. [Architecture](#architecture)
5. [File & folder conventions](#file--folder-conventions)
6. [Full directory tree](#full-directory-tree)
7. [Widget files by feature](#widget-files-by-feature)
8. [Shared components](#shared-components)
9. [Screens & routes](#screens--routes)
10. [Frontend completion](#frontend-completion)
11. [Backend integration](#backend-integration)
12. [Documentation](#documentation)

---

## What is Locals?

Locals helps users explore a city like a local:

- **Map** — interactive pin map with visited/unvisited locations, search, and filters
- **Explore** — stories (24h), featured spots, events, weekly rankings, find locals
- **Missions** — gamified location challenges and achievements
- **Rank** — city / country / global / followers leaderboards
- **Profile** — level, points, check-ins, settings, privacy, saved places

---

## Quick start

```bash
flutter pub get
flutter run
flutter analyze
```

**Design size:** 440 × 956 (`flutter_screenutil`)

---

## Project statistics

| Metric | Count |
|--------|------:|
| Dart files in lib/ | 342 |
| Screen files (*_screen.dart) | 42 |
| Feature widget files (`view/widgets/`) | 125 |
| Shared component files | 25 |
| Controllers | 41 |
| Repositories | 40 |
| Models / args | 54 |
| GoRouter routes | 37 |
| Feature modules | 8 top-level groups |

---

## Architecture

Feature-first **MVC + Repository** pattern:

```
Screen (*_screen.dart)
    |
    +-- widgets/          # UI building blocks
    |
Controller (*_controller.dart)   # ChangeNotifier, navigation, actions
    |
Repository (*_repository.dart)   # Data access (mock today -> API next)
    |
Model (*_model.dart, *_args.dart)
```

**State management:** provider + ChangeNotifierProvider per screen.

**Navigation:** go_router with ShellRoute (5 tabs) + root overlay routes.

**Data today:** Mock seed data inside models and *RepositoryImpl stubs. ExploreRepositoryImpl is a singleton for in-memory stories.

---

## File & folder conventions

| Pattern | Purpose | Example |
|---------|---------|---------|
| *_screen.dart | Full-page route target | explore_screen.dart |
| `view/widgets/*.dart` | Screen-specific widgets | `explore_header.dart` |
| *_controller.dart | UI logic & state | explore_controller.dart |
| *_repository.dart | Data contract + impl | explore_repository.dart |
| *_model.dart | Domain / UI state data | explore_model.dart |
| `*_args.dart` | Route `extra` payload | `view_profile_args.dart` |
| *_service.dart | Device / media helpers | story_upload_service.dart |

Standard feature layout:

```
lib/features/<group>/<feature>/
├── controller/
├── model/
├── repository/
├── service/          # optional
└── view/
    ├── <feature>_screen.dart
    └── widgets/
        └── *.dart
```

---

## Full directory tree

Complete tree of `lib/`, `assets/`, and `docs/` including every screen, widget, controller, model, and repository file.

Also saved as [docs/DIRECTORY_TREE.md](docs/DIRECTORY_TREE.md).

<details>
<summary><strong>Expand full directory tree (638 lines)</strong></summary>

```
lib/
|-- app/
|   |-- app.dart
|   |-- app_scaffold.dart
|   +-- router.dart
|-- core/
|   |-- media/
|   |   |-- avatar_picker_service.dart
|   |   +-- image_save_service.dart
|   |-- permissions/
|   |   |-- camera_permission.dart
|   |   +-- gallery_permission.dart
|   |-- startup/
|   |   +-- startup.dart
|   +-- core.dart
|-- features/
|   |-- account_create/
|   |   |-- signup/
|   |   |   |-- controller/
|   |   |   |   +-- signup_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- signup_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- signup_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- signup_form_fields.dart
|   |   |       |   |-- signup_header.dart
|   |   |       |   +-- signup_login_footer.dart
|   |   |       +-- signup_screen.dart
|   |   +-- verify_account_otp/
|   |       |-- controller/
|   |       |   +-- verify_account_otp_controller.dart
|   |       |-- model/
|   |       |   +-- verify_account_otp_model.dart
|   |       |-- repository/
|   |       |   +-- verify_account_otp_repository.dart
|   |       +-- view/
|   |           |-- widgets/
|   |           |   |-- email_verified_success_view.dart
|   |           |   +-- verify_account_otp_hint_text.dart
|   |           +-- verify_account_otp_screen.dart
|   |-- explore/
|   |   |-- events_progress_map/
|   |   |   |-- controller/
|   |   |   |   +-- events_progress_map_controller.dart
|   |   |   |-- model/
|   |   |   |   |-- events_progress_map_args.dart
|   |   |   |   +-- events_progress_map_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- events_progress_map_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- event_progress_stop_card.dart
|   |   |       |   +-- events_progress_bottom_panel.dart
|   |   |       +-- events_progress_map_screen.dart
|   |   |-- events_routes/
|   |   |   |-- controller/
|   |   |   |   +-- events_routes_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- events_routes_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- events_routes_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- event_route_card.dart
|   |   |       +-- events_routes_screen.dart
|   |   |-- explore/
|   |   |   |-- controller/
|   |   |   |   +-- explore_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- explore_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- explore_repository.dart
|   |   |   |-- service/
|   |   |   |   +-- story_upload_service.dart
|   |   |   |-- story/
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- explore_featured_locations_section.dart
|   |   |       |   |-- explore_featured_routes_section.dart
|   |   |       |   |-- explore_follow_card.dart
|   |   |       |   |-- explore_follow_locals_section.dart
|   |   |       |   |-- explore_header.dart
|   |   |       |   |-- explore_location_card.dart
|   |   |       |   |-- explore_new_local_item.dart
|   |   |       |   |-- explore_new_locals_section.dart
|   |   |       |   |-- explore_ranking_row.dart
|   |   |       |   |-- explore_recent_activity_section.dart
|   |   |       |   |-- explore_route_card.dart
|   |   |       |   |-- explore_section_header.dart
|   |   |       |   |-- explore_story_item.dart
|   |   |       |   |-- explore_weekly_ranking_section.dart
|   |   |       |   |-- explore_your_story_avatar.dart
|   |   |       |   +-- follow_user_avatar.dart
|   |   |       +-- explore_screen.dart
|   |   |-- featured_locations/
|   |   |   |-- controller/
|   |   |   |   +-- featured_locations_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- featured_locations_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- featured_locations_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- featured_location_card.dart
|   |   |       +-- featured_locations_screen.dart
|   |   |-- find_locals/
|   |   |   |-- controller/
|   |   |   |   +-- find_locals_controller.dart
|   |   |   |-- model/
|   |   |   |   |-- find_locals_args.dart
|   |   |   |   +-- find_locals_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- find_locals_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- find_local_card.dart
|   |   |       +-- find_locals_screen.dart
|   |   |-- join_event/
|   |   |   |-- controller/
|   |   |   |   +-- join_event_controller.dart
|   |   |   |-- model/
|   |   |   |   |-- join_event_args.dart
|   |   |   |   +-- join_event_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- join_event_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- join_event_hero_header.dart
|   |   |       |   |-- join_event_stats_row.dart
|   |   |       |   +-- join_event_stop_tile.dart
|   |   |       +-- join_event_screen.dart
|   |   |-- points/
|   |   |   |-- controller/
|   |   |   |   +-- points_controller.dart
|   |   |   |-- model/
|   |   |   |   |-- points_args.dart
|   |   |   |   +-- points_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- points_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- points_city_progress.dart
|   |   |       |   +-- points_success_icon.dart
|   |   |       +-- points_screen.dart
|   |   |-- restaurant_view_details/
|   |   |   |-- controller/
|   |   |   |   +-- restaurant_view_details_controller.dart
|   |   |   |-- model/
|   |   |   |   |-- restaurant_view_details_args.dart
|   |   |   |   +-- restaurant_view_details_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- restaurant_view_details_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- restaurant_action_buttons.dart
|   |   |       |   |-- restaurant_description_section.dart
|   |   |       |   |-- restaurant_hero_header.dart
|   |   |       |   |-- restaurant_info_rows.dart
|   |   |       |   |-- restaurant_photos_section.dart
|   |   |       |   |-- restaurant_visitors_section.dart
|   |   |       |   +-- share_location_bottom_sheet.dart
|   |   |       +-- restaurant_view_details_screen.dart
|   |   |-- share_card/
|   |   |   |-- controller/
|   |   |   |   +-- share_card_controller.dart
|   |   |   |-- model/
|   |   |   |   |-- share_card_args.dart
|   |   |   |   +-- share_card_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- share_card_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- share_card_actions.dart
|   |   |       |   |-- share_card_preview.dart
|   |   |       |   +-- share_card_stats_row.dart
|   |   |       |-- share_card_camera_screen.dart
|   |   |       +-- share_card_screen.dart
|   |   +-- story_view/
|   |       |-- controller/
|   |       |   +-- story_view_controller.dart
|   |       |-- model/
|   |       |   +-- story_view_args.dart
|   |       +-- view/
|   |           |-- widgets/
|   |           |   |-- story_progress_bar.dart
|   |           |   |-- story_reaction_bar.dart
|   |           |   |-- story_slide_image.dart
|   |           |   |-- story_viewer_header.dart
|   |           |   |-- story_viewer_insights_bar.dart
|   |           |   +-- story_viewers_bottom_sheet.dart
|   |           +-- story_view_screen.dart
|   |-- login/
|   |   |-- login/
|   |   |   |-- controller/
|   |   |   |   +-- login_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- login_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- login_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- login_form_fields.dart
|   |   |       |   |-- login_options_row.dart
|   |   |       |   |-- login_signup_footer.dart
|   |   |       |   +-- login_welcome_header.dart
|   |   |       +-- login_screen.dart
|   |   |-- request_otp/
|   |   |   |-- controller/
|   |   |   |   +-- request_otp_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- request_otp_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- request_otp_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- request_otp_form.dart
|   |   |       +-- request_otp_screen.dart
|   |   |-- set_new_password/
|   |   |   |-- controller/
|   |   |   |   +-- set_new_password_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- set_new_password_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- set_new_password_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- password_changed_success_view.dart
|   |   |       |   +-- set_new_password_login_link.dart
|   |   |       +-- set_new_password_screen.dart
|   |   +-- verify_otp/
|   |       |-- controller/
|   |       |   +-- verify_otp_controller.dart
|   |       |-- model/
|   |       |   +-- verify_otp_model.dart
|   |       |-- repository/
|   |       |   +-- verify_otp_repository.dart
|   |       +-- view/
|   |           |-- widgets/
|   |           |   |-- otp_input_row.dart
|   |           |   |-- verify_otp_hint_text.dart
|   |           |   +-- verify_otp_resend_row.dart
|   |           +-- verify_otp_screen.dart
|   |-- map/
|   |   |-- filters/
|   |   |   |-- controller/
|   |   |   |   +-- filters_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- filters_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- filters_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- filters_apply_button.dart
|   |   |       |   |-- filters_categories_section.dart
|   |   |       |   |-- filters_category_chip.dart
|   |   |       |   +-- filters_section_label.dart
|   |   |       +-- filters_screen.dart
|   |   |-- map/
|   |   |   |-- controller/
|   |   |   |   +-- map_controller.dart
|   |   |   |-- model/
|   |   |   |   |-- map_mission_args.dart
|   |   |   |   |-- map_model.dart
|   |   |   |   +-- map_screen_args.dart
|   |   |   |-- repository/
|   |   |   |   +-- map_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- map_background.dart
|   |   |       |   |-- map_circle_action_button.dart
|   |   |       |   |-- map_location_detail_card.dart
|   |   |       |   |-- map_mission_progress_card.dart
|   |   |       |   |-- map_pin_marker.dart
|   |   |       |   +-- map_search_bar.dart
|   |   |       +-- map_screen.dart
|   |   |-- notification/
|   |   |   |-- controller/
|   |   |   |   +-- notification_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- notification_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- notification_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- notification_card.dart
|   |   |       +-- notification_screen.dart
|   |   +-- search/
|   |       |-- controller/
|   |       |   +-- map_search_controller.dart
|   |       |-- model/
|   |       |   +-- map_search_model.dart
|   |       |-- repository/
|   |       |   +-- map_search_repository.dart
|   |       +-- view/
|   |           |-- widgets/
|   |           |   |-- map_search_chip.dart
|   |           |   +-- map_search_section.dart
|   |           +-- map_search_screen.dart
|   |-- missions/
|   |   |-- achievements/
|   |   |   |-- controller/
|   |   |   |   +-- achievements_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- achievements_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- achievements_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- achievement_grid_card.dart
|   |   |       |   +-- achievements_progress_card.dart
|   |   |       +-- achievements_screen.dart
|   |   |-- mission_details/
|   |   |   |-- controller/
|   |   |   |   +-- mission_details_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- mission_details_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- mission_details_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- mission_details_back_button.dart
|   |   |       |   |-- mission_details_continue_button.dart
|   |   |       |   |-- mission_details_header_card.dart
|   |   |       |   |-- mission_details_progress_section.dart
|   |   |       |   |-- mission_details_stop_tile.dart
|   |   |       |   +-- mission_details_stops_section.dart
|   |   |       +-- mission_details_screen.dart
|   |   +-- missions/
|   |       |-- controller/
|   |       |   +-- missions_controller.dart
|   |       |-- model/
|   |       |   +-- missions_model.dart
|   |       |-- repository/
|   |       |   +-- missions_repository.dart
|   |       +-- view/
|   |           |-- widgets/
|   |           |   |-- mission_card.dart
|   |           |   |-- missions_filter_chips.dart
|   |           |   +-- missions_header.dart
|   |           +-- missions_screen.dart
|   |-- onboard/
|   |   |-- controller/
|   |   |   +-- onboard_controller.dart
|   |   |-- model/
|   |   |   +-- onboard_model.dart
|   |   |-- repository/
|   |   |   +-- onboard_repository.dart
|   |   +-- view/
|   |       |-- widgets/
|   |       |   |-- onboard_carousel_page.dart
|   |       |   |-- onboard_location_page.dart
|   |       |   +-- onboard_top_bar.dart
|   |       +-- onboard_screen.dart
|   |-- profile/
|   |   |-- blocked_list/
|   |   |   |-- controller/
|   |   |   |   +-- blocked_list_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- blocked_list_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- blocked_list_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- blocked_user_item.dart
|   |   |       +-- blocked_list_screen.dart
|   |   |-- edit_profile/
|   |   |   |-- controller/
|   |   |   |   +-- edit_profile_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- edit_profile_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- edit_profile_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- edit_profile_avatar_section.dart
|   |   |       |   |-- edit_profile_form_field.dart
|   |   |       |   +-- edit_profile_password_section.dart
|   |   |       +-- edit_profile_screen.dart
|   |   |-- help_support/
|   |   |   |-- controller/
|   |   |   |   +-- help_support_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- help_support_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- help_support_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- help_compose_field.dart
|   |   |       |   |-- help_email_field.dart
|   |   |       |   +-- help_email_to_row.dart
|   |   |       +-- help_support_screen.dart
|   |   |-- list/
|   |   |   |-- controller/
|   |   |   |   +-- list_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- list_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- list_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- list_user_item.dart
|   |   |       +-- list_screen.dart
|   |   |-- manage_subscription/
|   |   |   |-- controller/
|   |   |   |   +-- manage_subscription_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- manage_subscription_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- manage_subscription_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- subscription_billing_section.dart
|   |   |       |   |-- subscription_payment_card.dart
|   |   |       |   |-- subscription_plan_card.dart
|   |   |       |   +-- subscription_settings_card.dart
|   |   |       +-- manage_subscription_screen.dart
|   |   |-- my_map/
|   |   |   |-- controller/
|   |   |   |   +-- my_map_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- my_map_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- my_map_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- my_map_legend.dart
|   |   |       +-- my_map_screen.dart
|   |   |-- privacy/
|   |   |   |-- controller/
|   |   |   |   +-- privacy_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- privacy_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- privacy_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- privacy_setting_row.dart
|   |   |       +-- privacy_screen.dart
|   |   |-- privacy_data/
|   |   |   |-- controller/
|   |   |   |   +-- privacy_data_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- privacy_data_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- privacy_data_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- privacy_delete_account_button.dart
|   |   |       |   |-- privacy_encryption_banner.dart
|   |   |       |   +-- privacy_legal_links.dart
|   |   |       +-- privacy_data_screen.dart
|   |   |-- privacy_policy/
|   |   |   |-- controller/
|   |   |   |   +-- privacy_policy_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- privacy_policy_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- privacy_policy_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       +-- privacy_policy_screen.dart
|   |   |-- profile/
|   |   |   |-- controller/
|   |   |   |   +-- profile_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- profile_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- profile_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- profile_achievements_section.dart
|   |   |       |   |-- profile_action_grid.dart
|   |   |       |   |-- profile_header.dart
|   |   |       |   |-- profile_latest_visits_section.dart
|   |   |       |   |-- profile_level_card.dart
|   |   |       |   |-- profile_stats_row.dart
|   |   |       |   |-- profile_top_actions.dart
|   |   |       |   +-- share_profile_bottom_sheet.dart
|   |   |       +-- profile_screen.dart
|   |   |-- saved_places/
|   |   |   |-- controller/
|   |   |   |   +-- saved_places_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- saved_places_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- saved_places_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- saved_place_card.dart
|   |   |       +-- saved_places_screen.dart
|   |   |-- set_notification/
|   |   |   |-- controller/
|   |   |   |   +-- set_notification_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- set_notification_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- set_notification_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   +-- notification_setting_tile.dart
|   |   |       +-- set_notification_screen.dart
|   |   |-- settings/
|   |   |   |-- controller/
|   |   |   |   +-- settings_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- settings_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- settings_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- settings_section_card.dart
|   |   |       |   +-- settings_tile.dart
|   |   |       +-- settings_screen.dart
|   |   +-- terms_of_use/
|   |       |-- controller/
|   |       |   +-- terms_of_use_controller.dart
|   |       |-- model/
|   |       |   +-- terms_of_use_model.dart
|   |       |-- repository/
|   |       |   +-- terms_of_use_repository.dart
|   |       +-- view/
|   |           |-- widgets/
|   |           +-- terms_of_use_screen.dart
|   |-- rank/
|   |   |-- rank/
|   |   |   |-- controller/
|   |   |   |   +-- rank_controller.dart
|   |   |   |-- model/
|   |   |   |   +-- rank_model.dart
|   |   |   |-- repository/
|   |   |   |   +-- rank_repository.dart
|   |   |   +-- view/
|   |   |       |-- widgets/
|   |   |       |   |-- rank_list_item.dart
|   |   |       |   |-- rank_period_tabs.dart
|   |   |       |   |-- rank_podium.dart
|   |   |       |   +-- rank_scope_chips.dart
|   |   |       +-- rank_screen.dart
|   |   +-- view_profile/
|   |       |-- controller/
|   |       |   +-- view_profile_controller.dart
|   |       |-- model/
|   |       |   |-- view_profile_args.dart
|   |       |   +-- view_profile_model.dart
|   |       |-- repository/
|   |       |   +-- view_profile_repository.dart
|   |       +-- view/
|   |           |-- widgets/
|   |           |   |-- view_profile_achievements_tab.dart
|   |           |   |-- view_profile_action_buttons.dart
|   |           |   |-- view_profile_header_section.dart
|   |           |   |-- view_profile_map_tab.dart
|   |           |   |-- view_profile_photos_tab.dart
|   |           |   +-- view_profile_stats_row.dart
|   |           +-- view_profile_screen.dart
|   +-- splash/
|       |-- controller/
|       |   +-- splash_controller.dart
|       |-- model/
|       |   +-- splash_model.dart
|       |-- repository/
|       |   +-- splash_repository.dart
|       +-- view/
|           |-- widgets/
|           |   |-- splash_background.dart
|           |   +-- splash_logo.dart
|           +-- splash_screen.dart
|-- shared/
|   |-- components/
|   |   |-- image_view/
|   |   |   |-- check_in_image_view.dart
|   |   |   +-- image_view_dialog.dart
|   |   |-- map/
|   |   |   |-- map_interactive_pin.dart
|   |   |   |-- map_pin_callout.dart
|   |   |   |-- map_pins_layer.dart
|   |   |   +-- scrollable_map_canvas.dart
|   |   |-- share/
|   |   |   |-- share_bottom_sheet_shell.dart
|   |   |   +-- share_link_row.dart
|   |   |-- auth_divider.dart
|   |   |-- auth_screen_header.dart
|   |   |-- auth_text_field.dart
|   |   |-- bottom_nav_bar.dart
|   |   |-- google_sign_in_button.dart
|   |   |-- legal_document_body.dart
|   |   |-- locals_logo.dart
|   |   |-- neumorphic_back_button.dart
|   |   |-- neumorphic_illustration_card.dart
|   |   |-- onboard_page_indicator.dart
|   |   |-- password_requirement_box.dart
|   |   |-- premium_confirm_dialog.dart
|   |   |-- primary_button.dart
|   |   |-- profile_screen_header.dart
|   |   |-- profile_segmented_control.dart
|   |   |-- secondary_outlined_button.dart
|   |   |-- story_avatar_ring.dart
|   |   +-- story_ring_style.dart
|   |-- model/
|   |   |-- check_in_photo_model.dart
|   |   |-- legal_document_section.dart
|   |   |-- map_pin_info.dart
|   |   +-- map_pin_tag.dart
|   |-- story/
|   |   +-- user_story_launcher.dart
|   |-- theme/
|   |   |-- app_assets.dart
|   |   +-- app_colors.dart
|   +-- widgets/
+-- main.dart

assets/
|-- logo/
|   |-- black_logo.png
|   |-- google.png
|   |-- logo.png
|   +-- rank_top.png
|-- onboard/
|   |-- location_4.png
|   |-- map_1.png
|   |-- map_pin_2.png
|   +-- tope_3.png
|-- unvisited/
|   |-- business.png
|   |-- point_of_interest.png
|   +-- sponsored_or_event.png
+-- visited/
    |-- business.png
    |-- point_of_interest.png
    +-- sponsored_or_event.png

docs/
|-- api/
|-- API_INTEGRATION.md
+-- PROJECT.md
```

</details>

---

## Widget files by feature

**account_create/signup/view** (3 widgets)
- signup_form_fields.dart
- signup_header.dart
- signup_login_footer.dart

**account_create/verify_account_otp/view** (2 widgets)
- email_verified_success_view.dart
- verify_account_otp_hint_text.dart

**explore/events_progress_map/view** (2 widgets)
- event_progress_stop_card.dart
- events_progress_bottom_panel.dart

**explore/events_routes/view** (1 widgets)
- event_route_card.dart

**explore/explore/view** (16 widgets)
- explore_featured_locations_section.dart
- explore_featured_routes_section.dart
- explore_follow_card.dart
- explore_follow_locals_section.dart
- explore_header.dart
- explore_location_card.dart
- explore_new_local_item.dart
- explore_new_locals_section.dart
- explore_ranking_row.dart
- explore_recent_activity_section.dart
- explore_route_card.dart
- explore_section_header.dart
- explore_story_item.dart
- explore_weekly_ranking_section.dart
- explore_your_story_avatar.dart
- follow_user_avatar.dart

**explore/featured_locations/view** (1 widgets)
- featured_location_card.dart

**explore/find_locals/view** (1 widgets)
- find_local_card.dart

**explore/join_event/view** (3 widgets)
- join_event_hero_header.dart
- join_event_stats_row.dart
- join_event_stop_tile.dart

**explore/points/view** (2 widgets)
- points_city_progress.dart
- points_success_icon.dart

**explore/restaurant_view_details/view** (7 widgets)
- restaurant_action_buttons.dart
- restaurant_description_section.dart
- restaurant_hero_header.dart
- restaurant_info_rows.dart
- restaurant_photos_section.dart
- restaurant_visitors_section.dart
- share_location_bottom_sheet.dart

**explore/share_card/view** (3 widgets)
- share_card_actions.dart
- share_card_preview.dart
- share_card_stats_row.dart

**explore/story_view/view** (6 widgets)
- story_progress_bar.dart
- story_reaction_bar.dart
- story_slide_image.dart
- story_viewer_header.dart
- story_viewer_insights_bar.dart
- story_viewers_bottom_sheet.dart

**login/login/view** (4 widgets)
- login_form_fields.dart
- login_options_row.dart
- login_signup_footer.dart
- login_welcome_header.dart

**login/request_otp/view** (1 widgets)
- request_otp_form.dart

**login/set_new_password/view** (2 widgets)
- password_changed_success_view.dart
- set_new_password_login_link.dart

**login/verify_otp/view** (3 widgets)
- otp_input_row.dart
- verify_otp_hint_text.dart
- verify_otp_resend_row.dart

**map/filters/view** (4 widgets)
- filters_apply_button.dart
- filters_categories_section.dart
- filters_category_chip.dart
- filters_section_label.dart

**map/map/view** (6 widgets)
- map_background.dart
- map_circle_action_button.dart
- map_location_detail_card.dart
- map_mission_progress_card.dart
- map_pin_marker.dart
- map_search_bar.dart

**map/notification/view** (1 widgets)
- notification_card.dart

**map/search/view** (2 widgets)
- map_search_chip.dart
- map_search_section.dart

**missions/achievements/view** (2 widgets)
- achievement_grid_card.dart
- achievements_progress_card.dart

**missions/mission_details/view** (6 widgets)
- mission_details_back_button.dart
- mission_details_continue_button.dart
- mission_details_header_card.dart
- mission_details_progress_section.dart
- mission_details_stop_tile.dart
- mission_details_stops_section.dart

**missions/missions/view** (3 widgets)
- mission_card.dart
- missions_filter_chips.dart
- missions_header.dart

**onboard/view** (3 widgets)
- onboard_carousel_page.dart
- onboard_location_page.dart
- onboard_top_bar.dart

**profile/blocked_list/view** (1 widgets)
- blocked_user_item.dart

**profile/edit_profile/view** (3 widgets)
- edit_profile_avatar_section.dart
- edit_profile_form_field.dart
- edit_profile_password_section.dart

**profile/help_support/view** (3 widgets)
- help_compose_field.dart
- help_email_field.dart
- help_email_to_row.dart

**profile/list/view** (1 widgets)
- list_user_item.dart

**profile/manage_subscription/view** (4 widgets)
- subscription_billing_section.dart
- subscription_payment_card.dart
- subscription_plan_card.dart
- subscription_settings_card.dart

**profile/my_map/view** (1 widgets)
- my_map_legend.dart

**profile/privacy/view** (1 widgets)
- privacy_setting_row.dart

**profile/privacy_data/view** (3 widgets)
- privacy_delete_account_button.dart
- privacy_encryption_banner.dart
- privacy_legal_links.dart

**profile/profile/view** (8 widgets)
- profile_achievements_section.dart
- profile_action_grid.dart
- profile_header.dart
- profile_latest_visits_section.dart
- profile_level_card.dart
- profile_stats_row.dart
- profile_top_actions.dart
- share_profile_bottom_sheet.dart

**profile/saved_places/view** (1 widgets)
- saved_place_card.dart

**profile/set_notification/view** (1 widgets)
- notification_setting_tile.dart

**profile/settings/view** (2 widgets)
- settings_section_card.dart
- settings_tile.dart

**rank/rank/view** (4 widgets)
- rank_list_item.dart
- rank_period_tabs.dart
- rank_podium.dart
- rank_scope_chips.dart

**rank/view_profile/view** (6 widgets)
- view_profile_achievements_tab.dart
- view_profile_action_buttons.dart
- view_profile_header_section.dart
- view_profile_map_tab.dart
- view_profile_photos_tab.dart
- view_profile_stats_row.dart

**splash/view** (2 widgets)
- splash_background.dart
- splash_logo.dart


---

## Shared components

Reusable widgets in lib/shared/components/ (used across features):

| File | Purpose |
|------|---------|
| uth_text_field.dart | Auth form input |
| uth_screen_header.dart | Auth page header |
| uth_divider.dart | Or divider |
| google_sign_in_button.dart | Google OAuth button |
| primary_button.dart | Pink CTA button |
| secondary_outlined_button.dart | Outlined button |
| ottom_nav_bar.dart | 5-tab navigation |
| locals_logo.dart | App logo |
| profile_screen_header.dart | Sub-screen header with back |
| profile_segmented_control.dart | Tab segmented control |
| 
eumorphic_back_button.dart | Neumorphic back |
| 
eumorphic_illustration_card.dart | Onboard illustration card |
| onboard_page_indicator.dart | Dot indicator |
| password_requirement_box.dart | Password rules UI |
| premium_confirm_dialog.dart | Animated logout/delete dialog |
| legal_document_body.dart | Legal text renderer |
| story_avatar_ring.dart | Story ring on avatar |
| story_ring_style.dart | Pink/gray ring colors |
| **map/** | |
| scrollable_map_canvas.dart | Pan/zoom map canvas |
| map_pins_layer.dart | Pin stack layer |
| map_interactive_pin.dart | Tappable pin + callout |
| map_pin_callout.dart | Name + level tooltip |
| **image_view/** | |
| image_view_dialog.dart | Full-screen photo dialog |
| check_in_image_view.dart | Check-in photo viewer |
| **share/** | |
| share_bottom_sheet_shell.dart | Share sheet shell |
| share_link_row.dart | Copy link row |

**Shared models:** map_pin_info.dart, map_pin_tag.dart, check_in_photo_model.dart, legal_document_section.dart

**Shared story:** user_story_launcher.dart — opens /story_view from any screen

**Theme:** pp_colors.dart, pp_assets.dart

---

## Screens & routes

**37 GoRouter paths** — 5 bottom tabs + auth + overlays.

### Bottom navigation

| Tab | Route | Screen file |
|-----|-------|-------------|
| Map | /map | map/map/view/map_screen.dart |
| Explore | /explore | explore/explore/view/explore_screen.dart |
| Missions | /missions | missions/missions/view/missions_screen.dart |
| Rank | /rank | 
ank/rank/view/rank_screen.dart |
| Profile | /profile | profile/profile/view/profile_screen.dart |

### All screens

| Route | Screen file |
|-------|-------------|
| /splash | splash/view/splash_screen.dart |
| /onboard | onboard/view/onboard_screen.dart |
| /login | login/login/view/login_screen.dart |
| /signup | ccount_create/signup/view/signup_screen.dart |
| /verify_account_otp | ccount_create/verify_account_otp/view/verify_account_otp_screen.dart |
| /request_otp | login/request_otp/view/request_otp_screen.dart |
| /verify_otp | login/verify_otp/view/verify_otp_screen.dart |
| /set_new_password | login/set_new_password/view/set_new_password_screen.dart |
| /story_view | explore/story_view/view/story_view_screen.dart |
| /find_locals | explore/find_locals/view/find_locals_screen.dart |
| /featured_locations | explore/featured_locations/view/featured_locations_screen.dart |
| /events_routes | explore/events_routes/view/events_routes_screen.dart |
| /join_event | explore/join_event/view/join_event_screen.dart |
| /events_progress_map | explore/events_progress_map/view/events_progress_map_screen.dart |
| /restaurant_view_details | explore/restaurant_view_details/view/restaurant_view_details_screen.dart |
| /points | explore/points/view/points_screen.dart |
| /share_card | explore/share_card/view/share_card_screen.dart |
| /map_search | map/search/view/map_search_screen.dart |
| /filters | map/filters/view/filters_screen.dart |
| /notification | map/notification/view/notification_screen.dart |
| /mission_details | missions/mission_details/view/mission_details_screen.dart |
| /achievements | missions/achievements/view/achievements_screen.dart |
| /view_profile | 
ank/view_profile/view/view_profile_screen.dart |
| /settings | profile/settings/view/settings_screen.dart |
| /edit_profile | profile/edit_profile/view/edit_profile_screen.dart |
| /privacy | profile/privacy/view/privacy_screen.dart |
| /privacy_data | profile/privacy_data/view/privacy_data_screen.dart |
| /set_notification | profile/set_notification/view/set_notification_screen.dart |
| /blocked_list | profile/blocked_list/view/blocked_list_screen.dart |
| /list | profile/list/view/list_screen.dart |
| /saved_places | profile/saved_places/view/saved_places_screen.dart |
| /my_map | profile/my_map/view/my_map_screen.dart |
| /help_support | profile/help_support/view/help_support_screen.dart |
| /privacy_policy | profile/privacy_policy/view/privacy_policy_screen.dart |
| /terms_of_use | profile/terms_of_use/view/terms_of_use_screen.dart |
| /manage_subscription | profile/manage_subscription/view/manage_subscription_screen.dart |

**Non-router screen:** explore/share_card/view/share_card_camera_screen.dart (pushed via Navigator)

---

## Frontend completion

- [x] Full navigation (37 routes, 5-tab shell)
- [x] Auth & onboarding UI flows
- [x] Map pins, callouts, pan/zoom, directions from location details
- [x] Explore feed, stories (24h, delete, viewers), rankings, find locals
- [x] Check-in to points screen
- [x] Missions, achievements, events progress map
- [x] Leaderboards + view profile
- [x] Profile, edit profile (avatar picker), settings, privacy
- [x] Saved places, followers, blocked list, my map
- [x] Premium confirm dialogs (logout, delete account)
- [x] Share card, legal screens, help & support

**Not yet done:** REST API, JWT persistence, push notifications, WebSocket

---

## Backend integration

Frontend is ready for API wiring — swap each *RepositoryImpl for HTTP calls.

| Category | ~Endpoints |
|----------|----------:|
| Authentication | 8 |
| User / Profile | 12 |
| Locations & Map | 10 |
| Check-ins & Points | 4 |
| Stories & Media | 9 |
| Social | 8 |
| Events & Missions | 11 |
| Leaderboard | 4 |
| Notifications | 5 |
| Search, Legal, Support, Subscriptions | 16 |
| **Total** | **~87** |

**Full API spec:** [docs/API_INTEGRATION.md](docs/API_INTEGRATION.md)

**Integration order:** Auth -> User profile -> Map/locations -> Explore/social -> Missions/events -> Notifications

---

## Documentation

| Document | Description |
|----------|-------------|
| [docs/PROJECT.md](docs/PROJECT.md) | Architecture deep-dive & checklist |
| [docs/DIRECTORY_TREE.md](docs/DIRECTORY_TREE.md) | Full directory tree (standalone) |
| [docs/API_INTEGRATION.md](docs/API_INTEGRATION.md) | ~87 APIs, screen mapping, examples |

---

## Dependencies

```yaml
go_router: ^14.1.0
provider: ^6.1.5+1
flutter_screenutil: ^5.9.3
flutter_neumorphic_plus: ^3.5.0
image_picker: ^1.1.2
camera: ^0.11.1
permission_handler: ^11.4.0
gal: ^2.3.1
url_launcher: ^6.3.1
```

---

## License

Private project — publish_to: none
