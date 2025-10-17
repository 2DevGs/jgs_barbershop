import 'package:jgs_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:jgs_barbershop/src/core/fp/either.dart';
import 'package:jgs_barbershop/src/core/fp/nil.dart';
import 'package:jgs_barbershop/src/model/barbershop_model.dart';
import 'package:jgs_barbershop/src/model/user_model.dart';

abstract interface class BarbershopRepository {

  Future<Either<RepositoryException, Nil>> save(({
    String name,
    String email,
    List<String> openingDays,
    List<int> openHours,
  }) data);

  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(UserModel userModel);
}