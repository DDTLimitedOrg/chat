import 'package:chatgpt_client/src/chat/presentation/cubit/messages_cubit.dart';
import 'package:chatgpt_client/src/chat/presentation/cubit/messages_state.dart';
import 'package:chatgpt_client/src/chat/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      height: 150,
      color: themeData.colorScheme.primary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocBuilder<MessagesCubit, MessageState>(
            builder: (context, state) {
              if (state is! MessageListState) {
                return const SizedBox();
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Avatar(
                    imagePath: state.character.imagePath,
                    size: 70,
                    action: () {
                      if (state is! MessageProcessingState) {
                        context.read<MessagesCubit>().chooseCharacterPressed();
                      }
                    },
                  ),
                  const Gap(12),
                  _chatInfo(state),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column _chatInfo(MessageListState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          state.character.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Text(
          'Online',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
