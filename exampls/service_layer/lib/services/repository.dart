import 'package:exapp/services/api_client.dart';

/// 더미 DataModel
class DataModel {
  final String title;
  final String content;

  DataModel({required this.title, required this.content});

  factory DataModel.formData(Map<String, String> data) {
    return DataModel(
        title: data['title'] ?? '', content: data['content'] ?? '');
  }
}

/// 더미 Repository
class Repository {
  final ApiClient apiClient;
  Repository({required this.apiClient});

  Future<List<DataModel>> getModels() {
    return apiClient
        .getDatas()
        .then((datas) => datas.map((e) => DataModel.formData(e)).toList());
  }

  dispose() {}
}
