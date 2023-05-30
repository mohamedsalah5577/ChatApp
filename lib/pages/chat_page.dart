import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:s/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message.dart';
import '../widgets/chat_buble.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessageCollection);
  final _controllerScrol = ScrollController();
  TextEditingController controllerText = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(

      stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),

      builder: (context, snapshot) {


        if (snapshot.hasData) {

          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        KLogo,
                        height: 50,
                      ),
                      const Text('Chat'),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _controllerScrol,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email
                              ? ChatBuble(
                                  message: messagesList[index],
                                )
                              : ChatBubleFrind(message: messagesList[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: controllerText,
                        onSubmitted: (data) {
                          messages.add({
                            KCreatedAt: DateTime.now(),
                            KMessage: data,
                            'id': email
                          });
                          controllerText.clear();

                          _controllerScrol.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          );
        } else {
          return const Text('Loading....');
        }
      },
    );
  }
}
