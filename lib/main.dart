import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/users_list/presentation/user_list_page.dart';

void main() {
  runApp(const ProviderScope(child: SofUserApp()));
}

class SofUserApp extends StatelessWidget {
  const SofUserApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.deepOrange,
      ),
      home: const UserListPage(),
    );
  }
}
