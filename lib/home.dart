import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supatest/user_model.dart';
import 'package:uuid/uuid.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final _nameController = TextEditingController();
final _ageController = TextEditingController();
final _idController = TextEditingController();
final supabaseClient = SupabaseClient(databaseUrl, databaseAnnonKey);

class _HomePageState extends State<HomePage> {
  void create() async {
    Map userData = {
      'id': const Uuid().v1(),
      'name': _nameController.text.trim(),
      'age': _ageController.text.trim(),
    };
    await supabaseClient.from('Users').insert(userData);
  }

  Future read() async {
    final userData = await supabaseClient.from('Users').select();
    return userData;
  }

  void update() async {
    Map updateMap = {
      'name': _nameController.text.trim(),
    };
    await supabaseClient
        .from('Users')
        .update(updateMap)
        .eq('id', _idController.text.trim());
  }

  void delete() async {
    await supabaseClient
        .from('Users')
        .delete()
        .eq('id', _idController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle:const  Text(
          'SupaBase CRUD',
          style: TextStyle(color: Colors.green),
        ),
        leading: IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(
              Icons.refresh,
              color: Colors.green,
            )),
        backgroundColor: Colors.black,
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      strokeAlign: StrokeAlign.outside)),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      strokeAlign: StrokeAlign.outside)),
              child: TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  hintText: 'Age',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      strokeAlign: StrokeAlign.outside)),
              child: TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  hintText: 'Id of data to be deleted',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: create,
              color: Colors.green,
              pressedOpacity: 0.3,
              child: const Text('Create'),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: read,
              color: Colors.blue,
              pressedOpacity: 0.3,
              child: const Text('Read'),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: update,
              color: Colors.brown,
              pressedOpacity: 0.3,
              child: const Text('Update'),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              onPressed: delete,
              color: Colors.red,
              pressedOpacity: 0.3,
              child: const Text('Delete'),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: FutureBuilder(
              future: read(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                }
                if (snapshot.data != null) {
                  return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var data = UserModel.fromJson(snapshot.data[index]);

                        return ListTile(
                          leading: Text(data.age),
                          title: Text(data.name),
                        );
                      });
                } else {
                  return const Center(
                    child: Text('No data'),
                  );
                }
              },
            ))
          ],
        ),
      ),
    ));
  }
}
