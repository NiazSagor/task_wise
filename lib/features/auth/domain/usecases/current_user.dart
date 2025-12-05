import 'package:fpdart/fpdart.dart';
import 'package:task_wise/core/common/entities/user.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
