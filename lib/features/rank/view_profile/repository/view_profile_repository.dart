import '../model/view_profile_model.dart';

abstract class ViewProfileRepository {
  ViewProfileModel load(String userId);
}

class ViewProfileRepositoryImpl implements ViewProfileRepository {
  static const _marta = ViewProfileModel(
    name: 'Marta Roig',
    level: 18,
    storyUserId: 'marta',
  );

  static const _aina = ViewProfileModel(
    name: 'Aina V.',
    level: 24,
    storyUserId: 'aina',
    visits: 84,
    followers: 612,
    cities: 4,
  );

  static const _joan = ViewProfileModel(
    name: 'Joan P.',
    level: 20,
    storyUserId: 'joan',
    visits: 51,
    followers: 328,
    cities: 2,
  );

  static const _paul = ViewProfileModel(
    name: 'Paul',
    level: 16,
    storyUserId: 'paul',
    visits: 38,
    followers: 215,
    cities: 2,
  );

  @override
  ViewProfileModel load(String userId) {
    return switch (userId) {
      'aina' => _aina,
      'joan' => _joan,
      'paul' => _paul,
      'marta' => _marta,
      _ => _marta,
    };
  }
}
