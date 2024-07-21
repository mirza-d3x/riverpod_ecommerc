import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/domain/repositories/product_repositories.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<ProductModel>> call() async {
    return await repository.getProducts();
  }
}
