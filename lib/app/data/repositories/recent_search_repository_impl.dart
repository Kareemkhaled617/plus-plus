import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/network/api_service.dart';
import '../../domain/repositories/recent_search_repository.dart';

import '../models/recent_search_model.dart';

class RecentSearchRepositoryImpl implements RecentSearchRepository {
  final ApiService apiService;

  RecentSearchRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<RecentSearchModel>>> getRecentSearches() async {
    final response = await apiService.getRequest('search/get-recent-search');

    if (response.success) {
      List<dynamic> data = response.data["data"];
      List<RecentSearchModel> searches =
          data.map((json) => RecentSearchModel.fromJson(json)).toList();
      return Right(searches);
    } else {
      return Left(Failure(response.message ?? "Failed to fetch recent searches",
          statusCode: response.statusCode));
    }
  }
}
