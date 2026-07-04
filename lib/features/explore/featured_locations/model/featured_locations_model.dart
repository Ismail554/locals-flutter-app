import 'package:flutter/material.dart';
import '../../explore/model/explore_model.dart';

class FeaturedLocationsModel {
  final List<ExploreFeaturedLocation> locations;
  final bool isLoading;
  final String? errorMessage;

  const FeaturedLocationsModel({
    this.locations = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  FeaturedLocationsModel copyWith({
    List<ExploreFeaturedLocation>? locations,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FeaturedLocationsModel(
      locations: locations ?? this.locations,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}