import 'package:flutter/material.dart';

class EditProfileModel {
  final String name;
  final String location;
  final Color avatarColor;
  final String? avatarImagePath;

  static const _defaultAvatarColor = Color(0xFFD4A574);

  const EditProfileModel({
    this.name = 'Marta',
    this.location = 'Barcelona',
    this.avatarColor = _defaultAvatarColor,
    this.avatarImagePath,
  });

  EditProfileModel copyWith({
    String? name,
    String? location,
    Color? avatarColor,
    String? avatarImagePath,
    bool clearAvatarImagePath = false,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      location: location ?? this.location,
      avatarColor: avatarColor ?? this.avatarColor,
      avatarImagePath:
          clearAvatarImagePath ? null : avatarImagePath ?? this.avatarImagePath,
    );
  }
}
