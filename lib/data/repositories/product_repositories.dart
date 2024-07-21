import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';

import '../sources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductModel>> getProducts() async {
    return await remoteDataSource.fetchProducts();
  }
}
