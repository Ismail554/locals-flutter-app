import 'package:flutter/material.dart';
import 'package:locals/shared/model/check_in_photo_model.dart';
import 'package:locals/features/explore/points/model/points_args.dart';
import 'package:locals/features/map/map/model/map_mission_args.dart';

class RestaurantPhoto {
  final Color color;
  final String timeAgo;
  final String caption;
  final int likes;

  const RestaurantPhoto({
    required this.color,
    required this.timeAgo,
    required this.caption,
    required this.likes,
  });

  CheckInPhoto toCheckInPhoto(String locationName) {
    return CheckInPhoto(
      previewColor: color,
      locationName: locationName,
      timeAgo: timeAgo,
      caption: caption,
      likes: likes,
    );
  }
}

class RestaurantViewDetailsModel {
  final String id;
  final String category;
  final String name;
  final bool hasLocalsSeal;
  final Color heroColor;
  final String shortDescription;
  final String fullDescription;
  final String address;
  final String hours;
  final String instagramHandle;
  final int points;
  final List<RestaurantPhoto> photos;
  final int visitorCount;
  final List<Color> visitorAvatarColors;
  final bool hasVisited;
  final bool isSaved;

  const RestaurantViewDetailsModel({
    required this.id,
    required this.category,
    required this.name,
    required this.hasLocalsSeal,
    required this.heroColor,
    required this.shortDescription,
    required this.fullDescription,
    required this.address,
    required this.hours,
    required this.instagramHandle,
    required this.points,
    required this.photos,
    required this.visitorCount,
    required this.visitorAvatarColors,
    this.hasVisited = false,
    this.isSaved = false,
  });

  String get shareUrl => 'https://local.app/l/$id';

  String get mapPinId => switch (id) {
        'sagrada_familia' => 'sagrada',
        _ => id,
      };

  PointsArgs toPointsArgs() {
    return PointsArgs(
      locationId: id,
      locationName: name,
      points: points,
      locationCategory: category,
      locationAddress: address,
      locationColor: heroColor,
    );
  }

  MapActiveLocation toMapLocation() {
    return MapActiveLocation(
      locationId: id,
      category: category,
      seal: hasLocalsSeal ? "locals' seal" : 'Local spot',
      name: name,
      address: address,
      points: points,
      imageColor: heroColor,
    );
  }

  RestaurantViewDetailsModel copyWith({
    bool? hasVisited,
    bool? isSaved,
  }) {
    return RestaurantViewDetailsModel(
      id: id,
      category: category,
      name: name,
      hasLocalsSeal: hasLocalsSeal,
      heroColor: heroColor,
      shortDescription: shortDescription,
      fullDescription: fullDescription,
      address: address,
      hours: hours,
      instagramHandle: instagramHandle,
      points: points,
      photos: photos,
      visitorCount: visitorCount,
      visitorAvatarColors: visitorAvatarColors,
      hasVisited: hasVisited ?? this.hasVisited,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  static const _fornBaluard = RestaurantViewDetailsModel(
    id: 'forn_baluard',
    category: 'BAKERY',
    name: 'Forn Baluard',
    hasLocalsSeal: true,
    heroColor: Color(0xFFE8D8C8),
    shortDescription:
        'A family-run bakery since 1945, famous for its sourdough and pastries.',
    fullDescription:
        'A family-run bakery since 1945, famous for its sourdough and pastries. '
        'Located near the beach in Barceloneta, Forn Baluard is a must-visit for '
        'anyone who loves traditional Catalan baking. Their croissants and ensaimadas '
        'are legendary among locals.',
    address: 'Carrer del Baluard 38',
    hours: '8:00 – 20:00',
    instagramHandle: '@p3.bcn',
    points: 60,
    photos: [
      RestaurantPhoto(
        color: Color(0xFFD4C4A0),
        timeAgo: '2d ago',
        caption: 'Fresh sourdough morning batch.',
        likes: 24,
      ),
      RestaurantPhoto(
        color: Color(0xFFC8B898),
        timeAgo: '5d ago',
        caption: 'Weekend pastry lineup.',
        likes: 18,
      ),
      RestaurantPhoto(
        color: Color(0xFFE0D0B8),
        timeAgo: '1w ago',
        caption: 'Behind the counter vibes.',
        likes: 31,
      ),
      RestaurantPhoto(
        color: Color(0xFFB8A888),
        timeAgo: '2w ago',
        caption: 'Best croissant in the neighborhood.',
        likes: 42,
      ),
    ],
    visitorCount: 248,
    visitorAvatarColors: [
      Color(0xFFD4A574),
      Color(0xFF7EB8DA),
      Color(0xFFE8A0A0),
      Color(0xFF9BB5CE),
      Color(0xFFC4B5A0),
      Color(0xFF8FA89A),
    ],
  );

  static const _cafeDelBorn = RestaurantViewDetailsModel(
    id: 'cafe_del_born',
    category: 'CAFE',
    name: 'Café del Born',
    hasLocalsSeal: true,
    heroColor: Color(0xFFD4C4B0),
    shortDescription:
        'A cozy café in the heart of El Born, perfect for morning coffee.',
    fullDescription:
        'A cozy café in the heart of El Born, perfect for morning coffee. '
        'Known for its artisan espresso and homemade pastries, Café del Born '
        'has been a neighborhood favorite for over a decade.',
    address: 'Carrer del Born 12',
    hours: '7:30 – 22:00',
    instagramHandle: '@cafedelborn',
    points: 50,
    photos: [
      RestaurantPhoto(
        color: Color(0xFFC8B8A8),
        timeAgo: '3d ago',
        caption: 'Best cortado in the Born.',
        likes: 27,
      ),
      RestaurantPhoto(
        color: Color(0xFFB0A090),
        timeAgo: '1w ago',
        caption: 'Morning light by the window.',
        likes: 15,
      ),
      RestaurantPhoto(
        color: Color(0xFFD8C8B8),
        timeAgo: '2w ago',
        caption: 'Homemade pastry of the day.',
        likes: 22,
      ),
    ],
    visitorCount: 186,
    visitorAvatarColors: [
      Color(0xFFD4A574),
      Color(0xFF7EB8DA),
      Color(0xFFE8A0A0),
      Color(0xFF9BB5CE),
      Color(0xFFC4B5A0),
    ],
  );

  static const _barMarsella = RestaurantViewDetailsModel(
    id: 'bar_marsella',
    category: 'BAR',
    name: 'Bar Marsella',
    hasLocalsSeal: false,
    heroColor: Color(0xFFB8C8D8),
    shortDescription:
        'Historic absinthe bar in El Raval, open since 1820.',
    fullDescription:
        'Historic absinthe bar in El Raval, open since 1820. '
        'Bar Marsella retains its vintage charm with original décor and '
        'a bohemian atmosphere that has attracted artists and writers for centuries.',
    address: 'Carrer de Sant Pau 65',
    hours: '18:00 – 02:00',
    instagramHandle: '@barmarsella',
    points: 40,
    photos: [
      RestaurantPhoto(
        color: Color(0xFFA8B8C8),
        timeAgo: '4d ago',
        caption: 'Late night absinthe hour.',
        likes: 56,
      ),
      RestaurantPhoto(
        color: Color(0xFF98A8B8),
        timeAgo: '2w ago',
        caption: 'Vintage interior details.',
        likes: 38,
      ),
    ],
    visitorCount: 312,
    visitorAvatarColors: [
      Color(0xFFD4A574),
      Color(0xFF7EB8DA),
      Color(0xFFE8A0A0),
      Color(0xFF9BB5CE),
    ],
  );

  static const _parcGuell = RestaurantViewDetailsModel(
    id: 'parc_guell',
    category: 'PARK',
    name: 'Parc Güell',
    hasLocalsSeal: true,
    heroColor: Color(0xFFC8D8B8),
    shortDescription:
        'Gaudí\'s whimsical park with stunning city views.',
    fullDescription:
        'Gaudí\'s whimsical park with stunning city views. '
        'A UNESCO World Heritage site featuring colorful mosaics, '
        'unique architecture, and panoramic views of Barcelona.',
    address: 'Carrer d\'Olot',
    hours: '9:30 – 19:30',
    instagramHandle: '@parkguell',
    points: 60,
    photos: [
      RestaurantPhoto(
        color: Color(0xFFB8D8A8),
        timeAgo: '1d ago',
        caption: 'Mosaic terrace views.',
        likes: 89,
      ),
      RestaurantPhoto(
        color: Color(0xFFA8C898),
        timeAgo: '1w ago',
        caption: 'Gaudí colors everywhere.',
        likes: 64,
      ),
      RestaurantPhoto(
        color: Color(0xFFC8E8B8),
        timeAgo: '3w ago',
        caption: 'Sunset from the park.',
        likes: 47,
      ),
    ],
    visitorCount: 1024,
    visitorAvatarColors: [
      Color(0xFFD4A574),
      Color(0xFF7EB8DA),
      Color(0xFFE8A0A0),
      Color(0xFF9BB5CE),
      Color(0xFFC4B5A0),
      Color(0xFF8FA89A),
    ],
  );

  static const _sagradaFamilia = RestaurantViewDetailsModel(
    id: 'sagrada_familia',
    category: 'MONUMENT',
    name: 'Sagrada Família',
    hasLocalsSeal: true,
    heroColor: Color(0xFFD0D8E0),
    shortDescription:
        'Gaudí\'s iconic basilica and UNESCO World Heritage site.',
    fullDescription:
        'Gaudí\'s iconic basilica and UNESCO World Heritage site. '
        'One of Barcelona\'s most visited landmarks, renowned for its '
        'towering spires and intricate facades.',
    address: 'Carrer de Mallorca 401',
    hours: '9:00 – 18:00',
    instagramHandle: '@sagradafamilia',
    points: 70,
    photos: [
      RestaurantPhoto(
        color: Color(0xFFC8D0D8),
        timeAgo: '2d ago',
        caption: 'Nativity facade detail.',
        likes: 52,
      ),
      RestaurantPhoto(
        color: Color(0xFFB8C0C8),
        timeAgo: '1w ago',
        caption: 'Morning light on the towers.',
        likes: 38,
      ),
    ],
    visitorCount: 2048,
    visitorAvatarColors: [
      Color(0xFFD4A574),
      Color(0xFF7EB8DA),
      Color(0xFFE8A0A0),
      Color(0xFF9BB5CE),
      Color(0xFFC4B5A0),
    ],
  );

  static RestaurantViewDetailsModel byId(String id) {
    return switch (id) {
      'cafe_del_born' => _cafeDelBorn,
      'bar_marsella' => _barMarsella,
      'forn_baluard' => _fornBaluard,
      'parc_guell' => _parcGuell,
      'sagrada_familia' => _sagradaFamilia,
      _ => _fornBaluard,
    };
  }
}
