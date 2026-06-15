import 'package:flutter/material.dart';

class EventRouteItem {
  final String id;
  final String dateLabel;
  final String title;
  final String organizer;
  final int points;
  final Color imageColor;

  const EventRouteItem({
    required this.id,
    required this.dateLabel,
    required this.title,
    required this.organizer,
    required this.points,
    required this.imageColor,
  });
}

class EventsRoutesModel {
  final List<EventRouteItem> events;

  const EventsRoutesModel({
    this.events = const [
      EventRouteItem(
        id: 'la_merce',
        dateLabel: 'SEP 22 - 25',
        title: 'La Mercè',
        organizer: 'Ajuntament de Barcelona',
        points: 1500,
        imageColor: Color(0xFF4A6A8A),
      ),
      EventRouteItem(
        id: 'tapas_route',
        dateLabel: 'ONGOING',
        title: 'Tapas Route',
        organizer: 'Estrella Damm',
        points: 800,
        imageColor: Color(0xFF8A7A6A),
      ),
      EventRouteItem(
        id: 'modernist_weekend',
        dateLabel: 'OCT 12 - 13',
        title: 'Modernist Weekend',
        organizer: 'Casa Batlló',
        points: 600,
        imageColor: Color(0xFF7A8A9A),
      ),
    ],
  });
}
