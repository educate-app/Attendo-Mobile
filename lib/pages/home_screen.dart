import 'package:attendo/pages/scanner_screen.dart';
import 'package:attendo/providers/auth_provider.dart';
import 'package:attendo/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //  Second variable to access the Logout Function
    final _auth = watch(authenticationProvider);
    final _user = watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: FaIcon(FontAwesomeIcons.doorOpen),
          )
        ],
      ),
      body: _user.when(
        data: (data) {
          return SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome,',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ));
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.qr_code_scanner),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => ScannerScreen(),
            // ));
          }),
    );
  }
}
