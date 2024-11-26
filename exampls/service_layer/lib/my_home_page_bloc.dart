import 'package:exapp/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class MyHomePageBloc {
  final Repository repository;
  final BehaviorSubject<int> _counter = BehaviorSubject<int>.seeded(0);
  Stream<int> get counterStream => _counter.stream;

  final BehaviorSubject<List<DataModel>> _models =
      BehaviorSubject<List<DataModel>>.seeded([]);

  Stream<List<DataModel>> get modelsStream => _models.stream;

  MyHomePageBloc({required this.repository});

  void incrementCounter() {
    _counter.add(_counter.value + 1);
  }

  loadDatas() async {
    final models = await repository.getModels();
    _models.add(models);
  }

  dispose() {
    _counter.close();
    _models.close();
  }
}
