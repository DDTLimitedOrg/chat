import 'package:chatgpt_client/src/chat/data/models/character.dart';
import 'package:chatgpt_client/src/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';
import 'package:chatgpt_client/src/chat/presentation/cubit/messages_cubit.dart';
import 'package:chatgpt_client/src/chat/presentation/cubit/messages_state.dart';
import 'package:chatgpt_client/src/chat/presentation/widgets/avatar.dart';
import 'package:chatgpt_client/src/chat/presentation/widgets/custom_app_bar.dart';
import 'package:chatgpt_client/src/chat/presentation/widgets/message_bubble.dart';
import 'package:chatgpt_client/src/chat/presentation/widgets/message_composer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessageState>(
      builder: (context, state) {
        return Stack(
          children: [
            _main(context),
          ],
        );
      },
    );
  }

  Scaffold _main(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<MessagesCubit, MessageState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: BlocBuilder<MessagesCubit, MessageState>(
                      builder: (context, state) {
                        if (state is MessageListState) {
                          final messages =
                              List<ChatMessage>.from(state.messages);
                          final name = state.character.name;

                          // we don't want to see the first message
                          if (messages.isNotEmpty) {
                            messages.removeAt(0);
                          }

                          return _messageList(messages, name);
                        } else if (state is ChatError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.message),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  BlocBuilder<MessagesCubit, MessageState>(
                    builder: (context, state) {
                      return MessageComposer(
                        onSubmitted: (message) async {
                          await context.read<MessagesCubit>().addMessage(
                                ChatMessageModel(
                                  content: message,
                                  isUserMessage: true,
                                ),
                              );
                        },
                        awaitingResponse: state is MessageProcessingState,
                      );
                    },
                  ),
                ],
              ),
              if (state is ChoosingCharacterState)
                _characterChooserDropdown(context, state),
            ],
          );
        },
      ),
    );
  }

  ListView _messageList(List<ChatMessage> messages, String name) {
    return ListView(
      reverse: true,
      children: [
        ...messages.toList().reversed.map(
              (msg) => Padding(
                padding: EdgeInsets.only(
                  left: msg.isUserMessage ? 32.0 : 0.0,
                  right: msg.isUserMessage ? 0.0 : 32.0,
                ),
                child: MessageBubble(
                  content: msg.content,
                  isUserMessage: msg.isUserMessage,
                  name: name,
                ),
              ),
            ),
      ],
    );
  }

  Widget _characterChooserDropdown(
    BuildContext context,
    ChoosingCharacterState state,
  ) {
    final themeData = Theme.of(context);

    return InkWell(
      onTap: () {
        context.read<MessagesCubit>().dismissCharacterChanged();
      },
      child: Padding(
        padding: const EdgeInsets.all(62),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ColoredBox(
            color: themeData.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: _children(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _children(BuildContext context) {
    return Character.allCharacters().asMap().entries.map((entry) {
      final index = entry.key;
      final val = entry.value;

      return SizedBox(
        height: 170,
        child: Column(
          children: [
            Avatar(
              imagePath: val.imagePath,
              size: 120,
              action: () {
                context.read<MessagesCubit>().characterChanged(index);
              },
            ),
            Text(
              val.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    }).toList();
  }
}
