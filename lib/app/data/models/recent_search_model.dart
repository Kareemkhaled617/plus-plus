import '../../domain/entities/recent_search_entity.dart';

class RecentSearchModel extends RecentSearchEntity {
  RecentSearchModel({
    required int id,
    required String searchTerm,
    required String searchType,
  }) : super(id: id, searchTerm: searchTerm, searchType: searchType);

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) {
    return RecentSearchModel(
      id: json["id"],
      searchTerm: json["search_term"],
      searchType: json["search_type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "search_term": searchTerm,
      "search_type": searchType,
    };
  }
}
