import '../model/share_card_args.dart';
import '../model/share_card_model.dart';

abstract class ShareCardRepository {
  ShareCardModel load(ShareCardArgs args);
}

class ShareCardRepositoryImpl implements ShareCardRepository {
  @override
  ShareCardModel load(ShareCardArgs args) {
    return ShareCardModel(
      cityLabel: args.cityLabel,
      level: args.level,
      points: args.points,
      cityPercent: args.cityPercent,
      previewColor: args.previewColor,
    );
  }
}
