
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:jgs_barbershop/src/config/env.dart';

final class RestClient extends DioForNative {
  RestClient() : super(BaseOptions(
    baseUrl: Env.backendBaseUrl,
    
  ));
}