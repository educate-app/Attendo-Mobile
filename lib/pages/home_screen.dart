import 'package:attendo/pages/scanner_screen.dart';
import 'package:attendo/providers/auth_provider.dart';
import 'package:attendo/providers/database_provider.dart';
import 'package:attendo/providers/firebaseProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // first variable is to get the data of Authenticated User
    final data = watch(fireBaseAuthProvider);

    //  Second variable to access the Logout Function
    final _auth = watch(authenticationProvider);

    final _database = watch(databaseProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data.currentUser!.email ?? 'You are logged In'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data.currentUser!.displayName ??
                  ' Great you have Completed this step'),
            ),
            Container(
              padding: const EdgeInsets.only(top: 48.0),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: MaterialButton(
                onPressed: () => _auth.signOut(),
                child: Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                textColor: Colors.blue.shade700,
                textTheme: ButtonTextTheme.primary,
                minWidth: 100,
                padding: const EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: Colors.blue.shade700),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.qr_code_scanner),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScannerScreen(
                name: data.currentUser!.displayName.toString(),
                classId: "z7eydjQbpZKGYQTtYdGX",
                enrollNo: "06015002819",
              ),
            ));
          }
      ),
    );
  }
}
