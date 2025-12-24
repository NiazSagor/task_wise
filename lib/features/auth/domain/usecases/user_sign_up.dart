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
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phoneNumber: params.phoneNumber,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}
