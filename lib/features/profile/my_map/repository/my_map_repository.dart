import 'package:locals/core/network/api_client.dart';
import 'package:locals/shared/model/map_pin_info.dart';
import 'package:locals/shared/model/map_pin_tag.dart';
import '../model/my_map_model.dart';

abstract class MyMapRepository {
  Future<MyMapModel> getPersonalMap();
}

class MyMapRepositoryImpl implements MyMapRepository {
  final ApiClient _client = ApiClient();

@override
Future<MyMapModel> getPersonalMap() async {
  final dynamic response = await _client.get('/places/me/personal-map/?filter=all');

  List<dynamic> rawList = [];

  if (response is List) {
    rawList = response;
  } else if (response is Map) {
    final data = response['data'] ?? response['results'] ?? response['places'];
    if (data is List) {
      rawList = data;
    }
  }

  final pins = rawList.map((item) {
    final map = item as Map<String, dynamic>;

    return MapPinInfo(
      id: map['place_id'].toString(),
      name: 'Visited Place',
      level: 1,
      lat: double.tryParse(map['latitude'].toString()) ?? 0.0,
      lng: double.tryParse(map['longitude'].toString()) ?? 0.0,
      tag: MapPinTag.business,
      visited: map['is_visited'] as bool? ?? false,
      category: map['category_slug'] as String?,
    );
  }).toList();

  return MyMapModel(pins: pins);
}
}