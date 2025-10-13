import 'package:jgs_barbershop/src/core/restClient/rest_client.dart';
import 'package:jgs_barbershop/src/repositories/user/user_repository.dart';
import 'package:jgs_barbershop/src/repositories/user/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(Ref ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));
