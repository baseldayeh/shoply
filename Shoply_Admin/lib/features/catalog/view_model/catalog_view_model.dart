import '../../../core/models/catalog.dart';
import '../data/catalog_repository.dart';

class CatalogViewModel {
  CatalogViewModel(this._repository);
  final CatalogRepository _repository;
  Stream<List<Category>> watchCategories() => _repository.watchCategories();
  Stream<List<Product>> watchProducts() => _repository.watchProducts();
  Stream<StoreBanner?> watchBanner() => _repository.watchBanner();

  String? requiredText(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;
  String? validateImageUrl(String? value) {
    final uri = Uri.tryParse(value?.trim() ?? '');
    return uri == null ||
            !['http', 'https'].contains(uri.scheme) ||
            uri.host.isEmpty
        ? 'Enter a valid HTTP(S) image URL'
        : null;
  }

  String? validatePrice(String? value) {
    final number = double.tryParse(value?.trim() ?? '');
    return number == null || !number.isFinite || number < 0
        ? 'Enter a valid non-negative price'
        : null;
  }

  Future<void> saveCategory(Category category) =>
      _repository.saveCategory(category);
  Future<void> deleteCategory(String id) => _repository.deleteCategory(id);
  Future<void> saveProduct(Product product) => _repository.saveProduct(product);
  Future<void> deleteProduct(Product product) =>
      _repository.deleteProduct(product);
  Future<void> saveBanner(StoreBanner banner) => _repository.saveBanner(banner);
  Future<void> importInitialCatalog() => _repository.importInitialCatalog();
}
