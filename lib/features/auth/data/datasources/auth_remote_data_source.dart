import 'package:dio/dio.dart';
import 'package:task_wise/core/error/exceptions.dart';
import 'package:task_wise/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  });

  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.post(
        "/Login",
        data: {"email": email, "password": password},
      );
      if (response.data["status"] != "success") {
        throw ServerException("User is null");
      }
      return response.data["token"];
    } on DioException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await client.post(
        "/Registration",
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
        },
      );
      if (response.data["status"] != "success") {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUserData() async {
    try {
      final response = await client.get("/ProfileDetails");
      if (response.data["status"] != "success") {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(response.data["data"][0]);
    } on DioException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
