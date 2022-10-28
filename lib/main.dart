import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'flutter secure storage',
      home: MyHomePage(title: 'flutter secure storage'),
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

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();
  }

  void getValues() async {
    name.text = await getValue("Name");
    email.text = await getValue("Email");
    address.text = await getValue("Address");
  }

  //function to save data
  Future<void> save(String key, String value)async{
    await secureStorage.write(key: key, value: value);
  }

  Future<String> getValue(String key) async{
    return await secureStorage.read(key: key) ?? "";
  }
  void saveDetails(){
    save("Name", name.text);
    save("Email", email.text);
    save("Address", address.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter Your Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter Your Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: address,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
                hintText: 'Enter Your Address',
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                  saveDetails();
                },
                child: const Text("Save Details"),
              )
          )
        ],
      ),
    );
  }
}

