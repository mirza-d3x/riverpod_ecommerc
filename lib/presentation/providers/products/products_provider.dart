import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/data/repositories/product_repositories.dart';
import 'package:ecommerce_app/data/sources/product_remote_data_source.dart';
import 'package:ecommerce_app/domain/use_cases/get_product_usecases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final getProductsProvider = Provider<GetProducts>(
  (ref) {
    final repository = ref.watch(productRepositoryProvider);
    return GetProducts(repository);
  },
);

final productRepositoryProvider = Provider<ProductRepositoryImpl>(
  (ref) {
    final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
    return ProductRepositoryImpl(remoteDataSource: remoteDataSource);
  },
);

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSourceImpl>(
  (ref) {
    return ProductRemoteDataSourceImpl(client: http.Client());
  },
);

final productListProvider = FutureProvider<List<ProductModel>>(
  (ref) async {
    final getProducts = ref.watch(getProductsProvider);
    return getProducts();
  },
);
