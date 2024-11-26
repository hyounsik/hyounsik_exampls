import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Provider<MyHomePageBloc>(
          create: (context) => MyHomePageBloc(),
          dispose: (context, value) => value.dispose(),
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

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
                return Text(
                  '${snapshot.data ?? 0}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
        ],
      ),
    );
  }
}

class MyHomePageBloc {
  final BehaviorSubject<int> _counter = BehaviorSubject<int>.seeded(0);
  Stream<int> get counterStream => _counter.stream;

  void incrementCounter() {
    _counter.add(_counter.value + 1);
  }

  dispose() {
    _counter.close();
  }
}
