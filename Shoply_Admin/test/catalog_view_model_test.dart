import 'package:flutter_test/flutter_test.dart';
import 'package:shoply_admin/core/models/catalog.dart';
import 'package:shoply_admin/features/catalog/data/catalog_repository.dart';
import 'package:shoply_admin/features/catalog/view_model/catalog_view_model.dart';

class FakeCatalogRepository implements CatalogRepository {
  Product? saved;
  @override
  Future<void> saveProduct(Product product) async {
    saved = product;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test(
    'product maps existing Firestore fields and preserves all images',
    () async {
      final repo = FakeCatalogRepository();
      final vm = CatalogViewModel(repo);
      final product = Product.fromMap('p1', 'c1', {
        'name': 'Watch',
        'description': 'A watch',
        'price': 20,
        'image': ['https://example.com/a.png', 'https://example.com/b.png'],
        'isTrending': true,
      });
      await vm.saveProduct(product);
      expect(repo.saved!.categoryId, 'c1');
      expect(repo.saved!.toMap()['price'], 20.0);
      expect(repo.saved!.toMap()['image'], hasLength(2));
      expect(repo.saved!.toMap()['isTrending'], isTrue);
    },
  );
  test('catalog input validation rejects invalid prices and image URLs', () {
    final vm = CatalogViewModel(FakeCatalogRepository());
    expect(vm.validatePrice('-1'), isNotNull);
    expect(vm.validatePrice('NaN'), isNotNull);
    expect(vm.validatePrice('12.50'), isNull);
    expect(vm.validateImageUrl('not a url'), isNotNull);
    expect(vm.validateImageUrl('https://example.com/image.png'), isNull);
  });
}
