// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:turktrip_app/app/app.dart';
import 'package:turktrip_app/app/providers.dart';
import 'package:turktrip_app/features/places/domain/entities/place.dart';
import 'package:turktrip_app/features/places/domain/repositories/place_repository.dart';

void main() {
  testWidgets('Place list shows fake data', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          placeRepositoryProvider.overrideWithValue(_FakePlaceRepository()),
        ],
        child: const TurkTripApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Aya Sofya'), findsOneWidget);
  });
}

class _FakePlaceRepository implements PlaceRepository {
  @override
  Future<List<Place>> getPlaces({String? citySlug, String? categorySlug}) async {
    return const [
      Place(id: 1, name: 'Aya Sofya', cityName: 'Istanbul'),
    ];
  }
}
