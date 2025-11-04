import 'package:jgs_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:jgs_barbershop/src/core/fp/either.dart';
import 'package:jgs_barbershop/src/core/fp/nil.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> scheduleClient(
    ({int babershopId, int userId, String clientName, DateTime date, int time})
    scheduleData,
  );
}
