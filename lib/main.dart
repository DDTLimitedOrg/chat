import 'package:chatgpt_client/core/services/injection_container.dart';
import 'package:chatgpt_client/src/chat/presentation/cubit/messages_cubit.dart';
import 'package:chatgpt_client/src/chat/presentation/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<MessagesCubit>())],
      child: MaterialApp(
        title: 'ChatGpt Demo',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyan,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
