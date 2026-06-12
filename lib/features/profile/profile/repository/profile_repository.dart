abstract class ProfileRepository {
  Future<void> init();
}

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<void> init() async {}
}
