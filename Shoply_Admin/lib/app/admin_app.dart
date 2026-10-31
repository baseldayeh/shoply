import 'package:flutter/material.dart';

import '../features/auth/view/auth_gate.dart';
import 'admin_services.dart';

class AdminApp extends StatefulWidget {
  const AdminApp({super.key, required this.services});
  final AdminServices services;
  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  @override
  void dispose() {
    widget.services.auth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AdminScope(
    services: widget.services,
    child: MaterialApp(
      title: 'Shoply Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff006a51)),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    ),
  );
}
