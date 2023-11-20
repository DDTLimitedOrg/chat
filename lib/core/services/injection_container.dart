import 'package:chatgpt_client/src/chat/data/datasources/chat_remote_data_source_implementation.dart';
import 'package:chatgpt_client/src/chat/data/repositories/chat_repository_implementation.dart';
import 'package:chatgpt_client/src/chat/domain/datasources/chat_remote_data_source.dart';
import 'package:chatgpt_client/src/chat/domain/repositories/chat_repository.dart';
import 'package:chatgpt_client/src/chat/domain/usecases/complete_chat.dart';
import 'package:chatgpt_client/src/chat/presentation/cubit/messages_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  sl
    // App Logic
    ..registerFactory(
      () => MessagesCubit(
        completeChat: sl(),
      ),
    )

    // Use cases
    ..registerLazySingleton(() => CompleteChat(sl()))

    // Repositories
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImplementation(sl()),
    )

    // Data Sources
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSrcImpl(sl()),
    )

    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
