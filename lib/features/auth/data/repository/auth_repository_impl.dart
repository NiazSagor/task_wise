import 'package:fpdart/fpdart.dart';
import 'package:task_wise/core/common/entities/user.dart';
import 'package:task_wise/core/constants/constants.dart';
import 'package:task_wise/core/error/exceptions.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/network/connection_checker.dart';
import 'package:task_wise/features/auth/data/datasources/auth_local_date_source.dart';
import 'package:task_wise/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task_wise/features/auth/data/models/user_model.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDatSource authLocalDatSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl(
    this.authRemoteDataSource,
    this.connectionChecker,
    this.authLocalDatSource,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = authRemoteDataSource.currentUserSession;
        if (session == null) {
          return left(Failure("User is not logged in"));
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? "",
            name: session.user.userMetadata?["name"],
          ),
        );
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure("User is not logged in"));
      }
      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginOfflineUser({
    required String id,
    required String name,
    required String email,
  }) async {
    final userModel = UserModel(id: id, email: email, name: name);
    await authLocalDatSource.insertUser(userModel);
    return right(userModel);
  }
}
