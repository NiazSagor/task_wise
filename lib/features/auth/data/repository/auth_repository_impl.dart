import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_wise/core/common/entities/user.dart';
import 'package:task_wise/core/constants/constants.dart';
import 'package:task_wise/core/error/exceptions.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/network/connection_checker.dart';
import 'package:task_wise/features/auth/data/datasources/auth_local_date_source.dart';
import 'package:task_wise/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDatSource authLocalDatSource;
  final SharedPreferences sharedPreferences;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDatSource,
    required this.sharedPreferences,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, User>> currentUser() async {
    if (sharedPreferences.getString(Constants.tokenKey) == null) {
      return left(Failure("User is not logged in"));
    }
    return _getUser(
      () async => await authRemoteDataSource.getCurrentUserData(),
    );
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final token = await authRemoteDataSource.loginWithEmailPassword(
      email: email,
      password: password,
    );
    await sharedPreferences.setString(Constants.tokenKey, token);
    return _getUser(
      () async => await authRemoteDataSource.getCurrentUserData(),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
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
    throw UnimplementedError();
  }
}
