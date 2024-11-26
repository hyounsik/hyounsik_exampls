import 'package:exapp/my_home_page_bloc.dart';
import 'package:exapp/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final MyHomePageBloc bloc;

  @override
  void initState() {
    bloc = context.read<MyHomePageBloc>();
    bloc.loadDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const BodyWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: bloc.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MyHomePageBloc>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          StreamBuilder<int>(
              stream: bloc.counterStream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Text(
                      '${snapshot.data ?? 0}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    StreamBuilder<List<DataModel>>(
                        stream: bloc.modelsStream,
                        builder: (context, snapshot) {
                          final models = snapshot.data ?? [];
                          return Column(
                              children: models
                                  .map((e) => ListTile(
                                        title: Text(e.title),
                                      ))
                                  .toList());
                        })
                  ],
                );
              }),
        ],
      ),
    );
  }
}
