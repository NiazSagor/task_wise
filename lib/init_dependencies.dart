import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_wise/core/common/cubits/app_user_cubit.dart';
import 'package:task_wise/core/network/connection_checker.dart';
import 'package:task_wise/core/secrets/app_secrets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_wise/features/auth/data/datasources/auth_local_date_source.dart';
import 'package:task_wise/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:task_wise/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_wise/features/auth/domain/repository/auth_repository.dart';
import 'package:task_wise/features/auth/domain/usecases/current_user.dart';
import 'package:task_wise/features/auth/domain/usecases/user_login.dart';
import 'package:task_wise/features/auth/domain/usecases/user_sign_up.dart';
import 'package:task_wise/features/auth/presentation/bloc/auth_bloc.dart';

part 'init_dependencies.main.dart';