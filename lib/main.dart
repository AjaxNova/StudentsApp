import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_app/presentation/splash_screen/splash_screen.dart';
import 'package:student_app/provider/photo_provider.dart';
import 'package:student_app/provider/provider.dart';

import 'database/model/model.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentDataAdapter().typeId)) {
    Hive.registerAdapter(StudentDataAdapter());
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => PhotoProviderNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) => StudentListProvider(),
    )
  ], child: const StudentApp()));
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider =
        Provider.of<StudentListProvider>(context, listen: false);
    counterProvider.getAllStudentList();

    return MaterialApp(
        home: const SplashScreen(),
        theme: ThemeData(
          primaryColor: Colors.black,
        ));
  }
}
