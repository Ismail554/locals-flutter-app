import 'package:flutter/material.dart';

class EditProfileModel {
  final String name;
  final String location;
  final Color avatarColor;
  final String? avatarImagePath;
  final String? avatarUrl;
  final bool isLoading;

  static const _defaultAvatarColor = Color(0xFFD4A574);

  const EditProfileModel({
    this.name = '',
    this.location = '',
    this.avatarColor = _defaultAvatarColor,
    this.avatarImagePath,
    this.avatarUrl,
    this.isLoading = false,
  });

  EditProfileModel copyWith({
    String? name,
    String? location,
    Color? avatarColor,
    String? avatarImagePath,
    String? avatarUrl,
    bool? isLoading,
    bool clearAvatarImagePath = false,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      location: location ?? this.location,
      avatarColor: avatarColor ?? this.avatarColor,
      avatarImagePath: clearAvatarImagePath
          ? null
          : avatarImagePath ?? this.avatarImagePath,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}