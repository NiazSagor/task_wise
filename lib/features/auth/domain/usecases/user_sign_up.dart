import 'package:fpdart/fpdart.dart';
import 'package:task_wise/core/common/entities/user.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';

class UserSignUpUseCase implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
