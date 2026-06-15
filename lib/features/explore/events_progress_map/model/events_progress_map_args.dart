class EventsProgressMapArgs {
  final String eventId;
  final int? completedStops;

  const EventsProgressMapArgs({
    required this.eventId,
    this.completedStops,
  });
}
