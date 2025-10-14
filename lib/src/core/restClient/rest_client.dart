import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:jgs_barbershop/src/config/env.dart';
import 'package:jgs_barbershop/src/core/restClient/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient()
    : super(
        BaseOptions(
          baseUrl: Env.backendBaseUrl,
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 60),
        ),
      ) {
    interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true,),
      AuthInterceptor(),
    ]);
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }
  
  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }

}
