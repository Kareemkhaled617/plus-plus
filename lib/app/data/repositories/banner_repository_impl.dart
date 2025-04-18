import '../../core/network/api_service.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/repositories/banner_repository.dart';
import '../models/banner_model.dart';

class BannerRepositoryImpl extends BannerRepository {
  final ApiService apiService;

  BannerRepositoryImpl(this.apiService);

  @override
  Future<List<BannerEntity>> fetchBanners() async {
    final response = await apiService.getRequest('banners');

    final List list = response.data['data']['banners'];
    return list.map((e) => BannerModel.fromJson(e)).toList();
  }
}
