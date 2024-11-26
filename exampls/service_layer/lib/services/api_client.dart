/// 더미 ApiClient
class ApiClient {
  final List<Map<String, String>> _mock = [
    {"title": "mock title 1", "content": "mock title 5"},
    {"title": "mock title 2", "content": "mock title 5"},
    {"title": "mock title 3", "content": "mock title 5"},
    {"title": "mock title 4", "content": "mock title 5"},
    {"title": "mock title 5", "content": "mock title 5"}
  ];

  Future<List<Map<String, String>>> getDatas() {
    return Future<List<Map<String, String>>>.delayed(
      const Duration(milliseconds: 500),
      () => _mock,
    );
  }

  dispose() {}
}
