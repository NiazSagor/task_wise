import 'package:fpdart/fpdart.dart';
import 'package:task_wise/core/common/entities/user.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';

class UserLoginUseCase implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
