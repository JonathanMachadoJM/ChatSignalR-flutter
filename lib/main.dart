import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  String grupo = '';
  String usuario = '';
  String mensagem = '';

  final serverUrl = "http://192.168.3.22:54970/chat/signalr";
  late HubConnection hubConnection;

  @override
  void initState() {
    super.initState();

    initSignalR();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Grupo',
                ),
                onChanged: (String value) {
                    setState(() {
                      grupo = value;
                    });
                  },
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuário',
                ),
                onChanged: (String value) {
                    setState(() {
                      usuario = value;
                    });
                  },
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mensagem',
                ),
                onChanged: (String value) {
                    setState(() {
                      mensagem = value;
                    });
                  },
              ),
              ElevatedButton(
                onPressed: () async {
                  
                  await hubConnection.invoke("SendMessage", args: <Object>[grupo,usuario,mensagem]);
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initSignalR() async {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose(({error}) {print("Connection Closed");});

    await hubConnection.start();

    
    hubConnection.on("ReceiveMessage", _handleAClientProvidedFunction);
  }

  void _handleAClientProvidedFunction(List<Object>? arguments) {

    print("Group" + arguments![0].toString());
    print("User" + arguments![1].toString());
    print("Msg" + arguments![2].toString());
  }
}



