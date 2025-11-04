import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jgs_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:jgs_barbershop/src/core/fp/either.dart';
import 'package:jgs_barbershop/src/core/fp/nil.dart';
import 'package:jgs_barbershop/src/core/restClient/rest_client.dart';

import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;

  ScheduleRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
    ({int babershopId, String clientName, DateTime date, int time, int userId})
    scheduleData,
  ) async {
    try {
      await restClient.auth.post(
        '/schedules',
        data: {
          'barbershop_id': scheduleData.babershopId,
          'user_id': scheduleData.userId,
          'client_name': scheduleData.clientName,
          'date': scheduleData.date.toIso8601String(),
          'time': scheduleData.time,
        },
      );
      return Success(Nil());
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(RepositoryException(message: 'Erro ao agendar horário'));
    }
  }
}
