import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:treinamento1/cubits/treinamento1/treinamento1_cubit.dart';
import 'package:treinamento1/pages/home_page.dart';
import 'package:treinamento1/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.instance.registerSingletonAsync<DbService>(() async {
    return DbService(
      box: await Hive.openBox('treinamento1'),
    );
  });

  await GetIt.instance.allReady();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<Treinamento1Cubit>(
            create: (_) {
              return Treinamento1Cubit(GetIt.instance.get<DbService>());
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
              canvasColor: Colors.transparent,
              scaffoldBackgroundColor: const Color(0x9a9a9a9a)
              // useMaterial3: true,
              ),
          home: const HomePage(),
        ));
  }
}
