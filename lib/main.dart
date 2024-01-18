import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imagegenerator/MyHttp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: Color.fromRGBO(	108, 99, 255,1),

      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  List<Message> messages = [];

  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage(String messageText) async {
    messages.add(Message(text: messageText, isSentByMe: true, imageUrl: ''));
    setState(() {

    });
     var sendData = await MyHttp.post("/image",{"description":messageText});
     print(sendData);
      var data = json.decode(sendData.body);
      print(data);
     messages.add(Message(text: "Here Is your Image", imageUrl: data["image"],isSentByMe: false));
    setState(() {

    });
    _textEditingController.clear();
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(title: Text('Chat App',style:TextStyle(color: Colors.white),),backgroundColor:Color.fromRGBO(	108, 99, 255,1),),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return _buildMessageItem(messages[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_textEditingController.text);
                    _textEditingController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Message message) {
    return Container(

      alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: message.isSentByMe
          ?
             Row(
               mainAxisAlignment:message.isSentByMe ?  MainAxisAlignment.end:MainAxisAlignment.start,
               children: [
                // Icon(Icons.account_circle,size: 30,),
                 Container(

                     padding: new EdgeInsets.all(10.0),
                     decoration: BoxDecoration(
                       color: Color.fromRGBO(	108, 99, 255,1),
                       borderRadius: BorderRadius.all(Radius.circular(10.0))

                     ),
                  margin:  EdgeInsets.all(10),

            child: Row(
                  children: [

                    Container(child: Text(message.text, style: TextStyle(fontSize: 18.0,color: Colors.white))),
                  ],
            )
                 ),
               ],
             )

          : Image.network(
        message.imageUrl,
        width: 200.0,
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

class Message {
  final String text;
  final bool isSentByMe;
  final String imageUrl;

  Message({required this.text, this.isSentByMe = false, required this.imageUrl});
}