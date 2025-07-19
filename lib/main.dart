import 'package:flutter/material.dart';

import 'core/injectable/get_it.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   configureDependencies();
  runApp(const WasilTaskApp());
}
class WasilTaskApp extends StatelessWidget {
  const WasilTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
}}
