import 'dart:async';
import 'dart:developer';

import 'package:exapp/di.dart';
import 'package:exapp/my_home_page.dart';
import 'package:exapp/my_home_page_bloc.dart';
import 'package:exapp/services/api_client.dart';
import 'package:exapp/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(
    () async {
      await configureDependencies();
      runApp(const MyApp());
    },
    (error, stack) {},
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp을 MultiProvider로 감싸고 서비스를 주입합니다.
    return MultiProvider(
      providers: [
        Provider.value(value: GetIt.I.get<ApiClient>()),
        Provider.value(value: GetIt.I.get<Repository>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Provider<MyHomePageBloc>(
            create: (context) {
              // 이제 앱 어디서든 BuildContext로 부터 Repository를 얻을 수 있습니다.
              final repo = context.read<Repository>();
              return MyHomePageBloc(repository: repo);
            },
            dispose: (context, value) => value.dispose(),
            child: const MyHomePage(title: 'Flutter Demo Home Page')),
      ),
    );
  }
}
