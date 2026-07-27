import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locals/features/profile/saved_places/model/saved_places_model.dart';
import 'package:locals/features/profile/saved_places/view/widgets/saved_place_card.dart';

void main() {
  testWidgets('shows an image when a saved place has an image URL', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SavedPlaceCard(
            place: const SavedPlace(
              id: '1',
              category: 'FOOD',
              name: 'Coffee House',
              imageColor: Color(0xFFD4C4B0),
              imageUrl: 'https://example.com/place.jpg',
            ),
            onTap: () {},
            onBookmarkTap: () {},
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}
