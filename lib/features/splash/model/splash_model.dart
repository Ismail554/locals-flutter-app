class SplashModel {
  final bool isLoading;

  const SplashModel({this.isLoading = true});

  SplashModel copyWith({bool? isLoading}) {
    return SplashModel(isLoading: isLoading ?? this.isLoading);
  }
}
