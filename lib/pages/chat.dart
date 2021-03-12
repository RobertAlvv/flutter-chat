import 'dart:io';
import 'dart:ui';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  List<ChatMessage> _messages = [];

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          title: Column(
            children: [
              CircleAvatar(
                child: Text('An'),
                backgroundColor: Colors.blue[100],
                maxRadius: 15,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Anabel Sandoval',
                style: TextStyle(color: Colors.black87, fontSize: 15),
              )
            ],
          )),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            ),
          ),
          Divider(height: 1),
          Container(
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: SafeArea(
        child: Row(
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: _textController,
                focusNode: _focusNode,
                onSubmitted: _handlerSummited,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration.collapsed(
                  hintText: 'Send Message',
                ),
              ),
            ),
            Platform.isIOS
                ? CupertinoButton(
                    child: Text('Send',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: _textController.text.trim().length > 0
                        ? () => _handlerSummited(_textController.text)
                        : null,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          Icons.send,
                        ),
                        onPressed: _textController.text.trim().length > 0
                            ? () => _handlerSummited(_textController.text)
                            : null,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _handlerSummited(String text) {
    if (text.length > 0) {
      AnimationController animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 250));

      final ChatMessage _newMessage = ChatMessage(
        uid: '123',
        message: text,
        animationController: animationController,
      );

      this._messages.insert(0, _newMessage);

      _newMessage.animationController.forward();

      _focusNode.requestFocus();
      _textController.clear();
      setState(() {});
    }
    _focusNode.requestFocus();
  }
}
