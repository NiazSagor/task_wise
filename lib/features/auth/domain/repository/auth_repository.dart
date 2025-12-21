import 'package:fpdart/fpdart.dart';
import 'package:task_wise/core/common/entities/user.dart';
import 'package:task_wise/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, User>> loginOfflineUser({
    required String id,
    required String name,
    required String email,
  });
}
