import 'dart:async';
import 'dart:convert';

import 'package:base_structure_using_mobx/app/controller/master_controller/master_controller.dart';
import 'package:base_structure_using_mobx/app/data/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

class HeadersInterceptor extends Interceptor {
  final log = Logger("HeadersInterceptor");
  final errorAuth = 401;
  Dio dioClient;

  HeadersInterceptor({required this.dioClient});

  @override
  Future<dynamic> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    MasterController masterController = GetIt.I<MasterController>();
    User user = await masterController.preferencesRepository.getUserPreferences();
    if(user.id.isNotEmpty){
      final tokenHeader = {"X-Access-Token":"${user.id}"};
      options.headers.addAll(tokenHeader);
    }
    log.info("uri:${options.uri}");
    log.info("baseURL:${options.baseUrl}");
    log.info("dataRequest: ${options.data}");
    log.info("HEADER: ${options.headers.toString()}");
    return super.onRequest(options,handler );
  }

  @override
  Future<FutureOr> onError(DioError dioError, ErrorInterceptorHandler handler) async {
    log.info("statusCode:${dioError.response!.statusCode}");
    log.info("statusMessage:${dioError.response!.statusMessage}");
    log.info("message :${dioError.message}");

    return dioError;
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    log.info("request ${response.data}");
    log.info("statusCode:${response.statusCode}");
    log.info("statusMessage:${response.statusMessage}");
    log.info(
        "dataResponse: ${response.statusCode} - ${response.data.path} - ${jsonEncode(response.data)}");
    return super.onResponse(response, handler);
  }
}