import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //show location permission dialog
    SharedPreferences.getInstance().then((prefs) {
      if (!prefs.containsKey('location_permission')) {
        Future.delayed(Duration(seconds: 1), () {
          showLocationPermissionDialog()
              .then((value) => showSmsPermissionDialog());
        });
        prefs.setBool('location_permission', false);
      }
    });
  }

  var list1 = <String>[
    'assets/1.jpeg',
    'assets/2.jpeg',
  ];

  var list2 = <String>[
    'assets/3.jpeg',
    'assets/4.jpeg',
    'assets/5.jpeg',
    'assets/6.jpeg',
    'assets/7.jpeg',
    'assets/8.jpeg',
  ];

  showSmsPermissionDialog() {
    //show dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SMS İzni'),
          content: const Text('SMS izni vermek ister misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İzin Verme'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('İzin Ver'),
            ),
          ],
        );
      },
    );
  }

  Future showLocationPermissionDialog() async {
    //show dialog
    final bool? isGranted = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konum İzni'),
          content: const Text('Konum izni vermek ister misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İzin Verme'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('İzin Ver'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sanatlar', style: Theme.of(context).textTheme.headline5),
            //listview
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list1.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                      child: Image.asset(list1[index], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            Text('Beğeniler', style: Theme.of(context).textTheme.headline5),

            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list2.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 200,
                    width: 100,
                    child: Card(
                      child: Image.asset(list2[index], fit: BoxFit.cover),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
