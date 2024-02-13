import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/api_services.dart';
//import 'package:riverpod_learn/statemanage.dart';
import 'package:riverpod_learn/user_model.dart';

// Making the instance of the Provider...
//final nameProvider = Provider<String>((ref) => "Hello Joel ADDITION");
final apiProvider = Provider<ApiService>((ref) => ApiService());
//
final userDataProvider = FutureProvider<List<UserModel>>(
  (ref) => ref.read(apiProvider).getUser(),
);

void main() {
  // Creating the Scope of the provider...
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      // Main(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('User Data'),
        centerTitle: true,
      ),
      body: userData.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("${data[index].firstname} ${data[index].lastname}"),
                subtitle: Text(data[index].email),
                leading: CircleAvatar(
                  child: Image.network(data[index].avatar),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


// class Main extends ConsumerStatefulWidget {
//   const Main({Key? key}) : super(key: key);

//   @override
//   ConsumerState<Main> createState() => _MainState();
// }

// class _MainState extends ConsumerState<Main> {
//   //
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final name = ref.read(nameProvider);
//     print(name);
//   }

//   //
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Riverpod Provider Example"),
//       ),
//       body: Center(
//         child: Consumer(
//           builder: (context, ref, _) {
//             final name = ref.watch(nameProvider);
//             return Text(name);
//           },
//         ),
//       ),
//     );
//   }
// }
