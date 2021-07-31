import 'package:base_structure_using_mobx/app/data/http/dio_interception_headers.dart';
import 'package:base_structure_using_mobx/app/data/http/dio_state.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class DioClient {

  Dio instance = Dio();
  final log = Logger("DioClient");

  static const int _SUCCESS = 200;
  static const int _UNAUTHORIZED = 401;

  DioClient(){
    BaseOptions options = BaseOptions(
      baseUrl: "ulr teste",
      responseType: ResponseType.json
    );
    instance = Dio(options);
    instance.interceptors.clear();
    instance.interceptors.add(HeadersInterceptor(dioClient: instance));
  }

  Future<DioState> post(String endpoint, String data,
      [queryParameters]) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await instance.post(endpoint,
          data: data, queryParameters: queryParameters);
      log.info(' ENDPOINT $endpoint executed in ${stopwatch.elapsed}');
      stopwatch.stop();
      if (response.statusCode == _SUCCESS) {
        return DioState(CustomState.SUCCESS, response);
      } else if (response.statusCode == _UNAUTHORIZED) {
        return DioState(CustomState.UNAUTHORIZED, response);
      }
      return DioState(CustomState.BAD_REQUEST, response);
    } on DioError catch (e) {
      print("BAD_REQUEST: $e");
      return DioState(CustomState.BAD_REQUEST, e.response!.data);
    }
  }

  Future<DioState> get(String endpoint,
      [queryParameters]) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await instance.get(
        endpoint,
        queryParameters: queryParameters,
      );
      log.info(' ENDPOINT $endpoint executed in ${stopwatch.elapsed}');
      stopwatch.stop();
      if (response.statusCode == _SUCCESS) {
        return DioState(CustomState.SUCCESS, response);
      } else if (response.statusCode == _UNAUTHORIZED) {
        return DioState(CustomState.UNAUTHORIZED, response);
      }
      return DioState(CustomState.BAD_REQUEST, response);
    } on DioError catch (e) {
      print("BAD_REQUEST: $e");
      return DioState(CustomState.BAD_REQUEST, e.response!.data);
    }
  }
}