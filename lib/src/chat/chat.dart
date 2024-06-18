import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unswipe/src/features/userProfile/data/model/create_request/response_profile_request.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.params,
  });

  final ChatPageParams params;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isAttachmentUploading = false;

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {},
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final updatedMessage = message.copyWith(isLoading: true);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.params.room.id,
          );

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final updatedMessage = message.copyWith(isLoading: false);
          FirebaseChatCore.instance.updateMessage(
            updatedMessage,
            widget.params.room.id,
          );
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance
        .updateMessage(updatedMessage, widget.params.room.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.params.room.id,
    );
  }

  void _setAttachmentUploading(bool uploading) {
    setState(() {
      _isAttachmentUploading = uploading;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 16.0,
          leading: Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.grey[700],
                ),
                onPressed: () {},
              )),
          title: Text(
            "Chat",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Playfair',
                fontWeight: FontWeight.w600,
                fontSize: 24.0),
          ),
        ),
        body: StreamBuilder<types.Room>(
          initialData: widget.params.room,
          stream: FirebaseChatCore.instance.room(widget.params.room.id),
          builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
              initialData: const [],
              stream: FirebaseChatCore.instance.messages(snapshot.data!),
              builder: (context, snapshot) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        'assets/images/permission_bg.png',
                      ),
                      fit: BoxFit.fill,
                    )),
                    child: Chat(
                      theme: DefaultChatTheme(
                          backgroundColor: Colors.transparent,
                      ),
                      isAttachmentUploading: false,
                      messages: snapshot.data ?? [],
                      onAttachmentPressed: _handleAtachmentPressed,
                      onMessageTap: _handleMessageTap,
                      onPreviewDataFetched: _handlePreviewDataFetched,
                      onSendPressed: _handleSendPressed,
                      user: types.User(
                        id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
                      ),
                    ),
                  )),
        ),
      );
}

class ChatPageParams {
  final Room room;
  final ResponseProfileCreateRequest request;

  ChatPageParams({required this.room, required this.request});
}
