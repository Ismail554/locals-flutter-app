import '../../explore/model/explore_model.dart';

abstract class FindLocalsRepository {
  List<ExploreFollowUser> buildUsers(List<ExploreFollowUser> followLocals);
}

class FindLocalsRepositoryImpl implements FindLocalsRepository {
  static const _allUsers = [
    ExploreFollowUser(id: 'marta', name: 'Marta Roig', level: 14),
    ExploreFollowUser(id: 'joan_bosch', name: 'Joan Bosch', level: 9),
    ExploreFollowUser(id: 'aina', name: 'Aina V.', level: 24),
    ExploreFollowUser(id: 'joan', name: 'Joan P.', level: 18),
    ExploreFollowUser(id: 'nuria', name: 'Núria T.', level: 16),
    ExploreFollowUser(id: 'paul', name: 'Paul M.', level: 15),
    ExploreFollowUser(id: 'marc', name: 'Marc B.', level: 12),
    ExploreFollowUser(id: 'laia', name: 'Laia M.', level: 18),
  ];

  @override
  List<ExploreFollowUser> buildUsers(List<ExploreFollowUser> followLocals) {
    final followById = {for (final user in followLocals) user.id: user};

    return _allUsers
        .map((user) {
          final synced = followById[user.id];
          if (synced != null) {
            return user.copyWith(isFollowing: synced.isFollowing);
          }
          return user;
        })
        .toList();
  }
}
