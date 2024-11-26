import 'package:exapp/services/api_client.dart';
import 'package:exapp/services/repository.dart';
import 'package:get_it/get_it.dart';

Future configureDependencies() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<ApiClient>(
    ApiClient(),
    dispose: (param) => param.dispose(),
  );

  getIt.registerSingleton<Repository>(
    Repository(apiClient: getIt.get<ApiClient>()),
    dispose: (param) => param.dispose(),
  );

  return getIt.allReady();
}
