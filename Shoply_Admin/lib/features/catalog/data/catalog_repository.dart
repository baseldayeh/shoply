import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../../core/models/catalog.dart';

abstract interface class CatalogRepository {
  Stream<List<Category>> watchCategories();
  Stream<List<Product>> watchProducts();
  Stream<StoreBanner?> watchBanner();
  Future<void> saveCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<void> saveProduct(Product product);
  Future<void> deleteProduct(Product product);
  Future<void> saveBanner(StoreBanner banner);
  Future<void> importInitialCatalog();
}

class FirestoreCatalogRepository implements CatalogRepository {
  FirestoreCatalogRepository(this._db, this._assets);
  final FirebaseFirestore _db;
  final AssetBundle _assets;
  CollectionReference<Map<String, dynamic>> get _categories =>
      _db.collection('Categories');
  CollectionReference<Map<String, dynamic>> get _sales =>
      _db.collection('Sales');

  @override
  Stream<List<Category>> watchCategories() => _categories.snapshots().map(
    (snapshot) => snapshot.docs
        .map((doc) => Category.fromMap(doc.id, doc.data()))
        .toList(),
  );
  @override
  Stream<List<Product>> watchProducts() => _db
      .collectionGroup('products')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .where((doc) => doc.reference.parent.parent != null)
            .map(
              (doc) => Product.fromMap(
                doc.id,
                doc.reference.parent.parent!.id,
                doc.data(),
              ),
            )
            .toList(),
      );
  @override
  Stream<StoreBanner?> watchBanner() => _sales
      .limit(1)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.isEmpty
            ? null
            : StoreBanner.fromMap(
                snapshot.docs.first.id,
                snapshot.docs.first.data(),
              ),
      );

  @override
  Future<void> saveCategory(Category category) async {
    final ref = category.id.isEmpty
        ? _categories.doc()
        : _categories.doc(category.id);
    await ref.set({
      'id': ref.id,
      'name': category.name,
      'image': category.imageUrl,
    }, SetOptions(merge: true));
  }

  @override
  Future<void> deleteCategory(String id) async {
    final ref = _categories.doc(id);
    if ((await ref.collection('products').limit(1).get()).docs.isNotEmpty) {
      throw StateError('Delete the products in this category first.');
    }
    await ref.delete();
  }

  @override
  Future<void> saveProduct(Product product) async {
    final collection = _categories
        .doc(product.categoryId)
        .collection('products');
    final ref = product.id.isEmpty
        ? collection.doc()
        : collection.doc(product.id);
    await ref.set({...product.toMap(), 'id': ref.id}, SetOptions(merge: true));
  }

  @override
  Future<void> deleteProduct(Product product) => _categories
      .doc(product.categoryId)
      .collection('products')
      .doc(product.id)
      .delete();
  @override
  Future<void> saveBanner(StoreBanner banner) =>
      _sales.doc(banner.id.isEmpty ? 'banner' : banner.id).set({
        'id': banner.id.isEmpty ? 'banner' : banner.id,
        'image': banner.imageUrl,
      }, SetOptions(merge: true));

  @override
  Future<void> importInitialCatalog() async {
    if ((await _categories.limit(1).get()).docs.isNotEmpty ||
        (await _sales.limit(1).get()).docs.isNotEmpty) {
      throw StateError(
        'The catalog is not empty. Import stopped without changing data.',
      );
    }
    final data = jsonDecode(
      await _assets.loadString('assets/catalog.json'),
    ) as Map<String, dynamic>;
    final batch = _db.batch();
    for (final item in data['categories'] as List) {
      batch.set(
        _categories.doc(item['id'] as String),
        Map<String, dynamic>.from(item['fields'] as Map),
      );
    }
    (data['products'] as Map<String, dynamic>).forEach((categoryId, products) {
      for (final item in products as List) {
        batch.set(
          _categories
              .doc(categoryId)
              .collection('products')
              .doc(item['id'] as String),
          Map<String, dynamic>.from(item['fields'] as Map),
        );
      }
    });
    for (final item in data['sales'] as List) {
      batch.set(
        _sales.doc(item['id'] as String),
        Map<String, dynamic>.from(item['fields'] as Map),
      );
    }
    await batch.commit();
  }
}
