import 'package:flutter/material.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';

class EventProgressStop {
  final int number;
  final String name;
  final Color thumbnailColor;
  final bool isCompleted;
  final int points;

  const EventProgressStop({
    required this.number,
    required this.name,
    required this.thumbnailColor,
    required this.isCompleted,
    this.points = 50,
  });

  EventProgressStop copyWith({bool? isCompleted}) {
    return EventProgressStop(
      number: number,
      name: name,
      thumbnailColor: thumbnailColor,
      isCompleted: isCompleted ?? this.isCompleted,
      points: points,
    );
  }
}

class EventsProgressMapModel {
  final String eventId;
  final String title;
  final int totalStops;
  final int completedStops;
  final List<EventProgressStop> stops;
  final List<MapPinInfo> pins;

  const EventsProgressMapModel({
    required this.eventId,
    required this.title,
    required this.totalStops,
    required this.completedStops,
    required this.stops,
    required this.pins,
  });

  double get progress =>
      totalStops == 0 ? 0 : completedStops / totalStops;

  String get progressLabel => '$completedStops/$totalStops Stops';

  EventProgressStop? get nextStop {
    for (final stop in stops) {
      if (!stop.isCompleted) return stop;
    }
    return null;
  }

  bool get canCheckIn => nextStop != null;

  EventsProgressMapModel copyWith({
    int? completedStops,
    List<EventProgressStop>? stops,
  }) {
    return EventsProgressMapModel(
      eventId: eventId,
      title: title,
      totalStops: totalStops,
      completedStops: completedStops ?? this.completedStops,
      stops: stops ?? this.stops,
      pins: pins,
    );
  }

  EventsProgressMapModel withCompletedStops(int count) {
    final updatedStops = stops
        .map((stop) => stop.copyWith(isCompleted: stop.number <= count))
        .toList();
    return copyWith(completedStops: count, stops: updatedStops);
  }
static const _defaultPins = [
  MapPinInfo(
    id: 'cafe_del_born',
    name: 'Café del Born',
    level: 12,
    lat: 23.8103,
    lng: 90.4125,
    tag: MapPinTag.business,
    visited: true,
  ),

  MapPinInfo(
    id: 'parc_guell',
    name: 'Parc Güell',
    level: 8,
    lat: 41.4145,
    lng: 2.1527,
    tag: MapPinTag.pointOfInterest,
    visited: false,
  ),

  MapPinInfo(
    id: 'forn_baluard',
    name: 'Forn Baluard',
    level: 6,
    lat: 41.3825,
    lng: 2.1769,
    tag: MapPinTag.business,
    visited: false,
  ),

  MapPinInfo(
    id: 'casa_batllo',
    name: 'Casa Batlló',
    level: 16,
    lat: 41.3917,
    lng: 2.1649,
    tag: MapPinTag.sponsoredOrEvent,
    visited: true,
  ),

  MapPinInfo(
    id: 'bar_marsella',
    name: 'Bar Marsella',
    level: 10,
    lat: 41.3792,
    lng: 2.1649,
    tag: MapPinTag.business,
    visited: true,
  ),

  MapPinInfo(
    id: 'sagrada',
    name: 'Sagrada Família',
    level: 18,
    lat: 41.4036,
    lng: 2.1744,
    tag: MapPinTag.pointOfInterest,
    visited: false,
  ),

  MapPinInfo(
    id: 'modernist_trail',
    name: 'Modernist Trail',
    level: 14,
    lat: 41.3954,
    lng: 2.1619,
    tag: MapPinTag.sponsoredOrEvent,
    visited: false,
  ),
];

  static EventsProgressMapModel byEventId(String eventId) {
    return switch (eventId) {
      'la_merce' => _build(
          eventId: eventId,
          title: 'La Mercè',
          totalStops: 7,
          completedStops: 0,
          stopNames: const [
            'Café del Born',
            'Bar Marsella',
            'Forn Baluard',
            'Sagrada Família',
            'Bunkers del Carmel',
            'Plaça Reial',
            'Parc Güell',
          ],
        ),
      'tapas_route' => _build(
          eventId: eventId,
          title: 'Tapas Route',
          totalStops: 7,
          completedStops: 2,
          stopNames: const [
            'Café del Born',
            'Bar Marsella',
            'Forn Baluard',
            'Bar Pinotxo',
            'Quimet & Quimet',
            'Cervecería Catalana',
            'La Cova Fumada',
          ],
        ),
      'modernist_weekend' => _build(
          eventId: eventId,
          title: 'Modernist Trail',
          totalStops: 7,
          completedStops: 2,
          stopNames: const [
            'Café del Born',
            'Bar Marsella',
            'Forn Baluard',
            'Casa Batlló',
            'La Pedrera',
            'Hospital de Sant Pau',
            'Palau de la Música',
          ],
        ),
      _ => _build(
          eventId: eventId,
          title: 'Modernist Trail',
          totalStops: 7,
          completedStops: 2,
          stopNames: const [
            'Café del Born',
            'Bar Marsella',
            'Forn Baluard',
            'Casa Batlló',
            'La Pedrera',
            'Hospital de Sant Pau',
            'Palau de la Música',
          ],
        ),
    };
  }

  static EventsProgressMapModel _build({
    required String eventId,
    required String title,
    required int totalStops,
    required int completedStops,
    required List<String> stopNames,
  }) {
    const colors = [
      Color(0xFFD4C4B0),
      Color(0xFFB8C8D8),
      Color(0xFFE8D8C8),
      Color(0xFFD0D8E0),
      Color(0xFFC8D8B8),
      Color(0xFFB8A898),
      Color(0xFF9BB5CE),
    ];

    final stops = List<EventProgressStop>.generate(stopNames.length, (index) {
      return EventProgressStop(
        number: index + 1,
        name: stopNames[index],
        thumbnailColor: colors[index % colors.length],
        isCompleted: index < completedStops,
      );
    });

    return EventsProgressMapModel(
      eventId: eventId,
      title: title,
      totalStops: totalStops,
      completedStops: completedStops,
      stops: stops,
      pins: _defaultPins,
    );
  }
}
