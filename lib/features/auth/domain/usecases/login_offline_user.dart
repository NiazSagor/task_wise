
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';

class LoginOfflineUserUseCase implements UseCase<User, LoginOfflineUserParams> {
  final AuthRepository authRepository;

  LoginOfflineUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(LoginOfflineUserParams params) async {
    throw Exception("Not needed right now");
  }
}

class LoginOfflineUserParams {
  final String id;
  final String email;
  final String name;

  LoginOfflineUserParams(this.id, this.email, this.name);
}
