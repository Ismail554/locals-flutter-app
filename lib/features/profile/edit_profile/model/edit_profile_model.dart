import 'package:flutter/material.dart';

class EditProfileModel {
  final String name;
  final String location;
  final Color avatarColor;

  static const _defaultAvatarColor = Color(0xFFD4A574);

  const EditProfileModel({
    this.name = 'Marta',
    this.location = 'Barcelona',
    this.avatarColor = _defaultAvatarColor,
  });

  EditProfileModel copyWith({
    String? name,
    String? location,
    Color? avatarColor,
  }) {
    return EditProfileModel(
      name: name ?? this.name,
      location: location ?? this.location,
      avatarColor: avatarColor ?? this.avatarColor,
    );
  }
}
