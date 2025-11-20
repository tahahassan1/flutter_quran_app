import 'package:dio/dio.dart';

class DioConsumer {
  Dio dio = Dio();

  Future<Response> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response;
    } on DioException catch (e) {
      throw DioException(error: e, requestOptions: RequestOptions());
    }
  }
}
