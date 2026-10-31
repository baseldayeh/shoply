import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/admin_app.dart';
import 'app/admin_services.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/view_model/auth_view_model.dart';
import 'features/catalog/data/catalog_repository.dart';
import 'features/catalog/view_model/catalog_view_model.dart';
import 'features/orders/data/orders_repository.dart';
import 'features/orders/view_model/orders_view_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final database = FirebaseFirestore.instance;
  runApp(
    AdminApp(
      services: AdminServices(
        auth: AuthViewModel(
          FirebaseAuthRepository(FirebaseAuth.instance, database),
        ),
        catalog: CatalogViewModel(
          FirestoreCatalogRepository(database, rootBundle),
        ),
        orders: OrdersViewModel(FirestoreOrdersRepository(database)),
      ),
    ),
  );
}
