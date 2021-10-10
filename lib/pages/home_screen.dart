// ignore_for_file: must_be_immutable

import 'package:attendo/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:attendo/models/form_model.dart';
import 'package:attendo/providers/auth_provider.dart';
import 'package:attendo/providers/database_provider.dart';
import 'package:attendo/providers/user_data_provider.dart';
import 'package:intl/intl.dart';

import 'scanner_screen.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';
  HomePage({Key? key}) : super(key: key);

  List<ClassTileWidget> _liveClasses = [];
  List<ClassTileWidget> _pastClasses = [];
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //  Second variable to access the Logout Function
    final _auth = watch(authenticationProvider);
    final _user = watch(userProvider);
    FormModel? _userData = watch(currUserProvider).state;
    final _classesLive = watch(liveClassesProvider);
    final _classesPast = watch(pastClassesProvider);

    _classesPast.whenData((value) {
      value?.forEach((element) {
        final id = element.id;
        final model = element.data();
        _pastClasses.add(ClassTileWidget(
            name: model.name, live: model.live, date: model.createdOn, id: id));
      });
    });

    _classesLive.whenData((value) {
      value?.forEach((element) {
        final id = element.id;
        final model = element.data();
        _liveClasses.add(ClassTileWidget(
            name: model.name, live: model.live, date: model.createdOn, id: id));
      });
    });

    print(_liveClasses.length);

    _user.whenData((data) => _userData = data);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Tooltip(
            message: 'Logout',
            child: IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: FaIcon(FontAwesomeIcons.doorOpen),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Welcome, ${_userData?.name}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            if (_liveClasses.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Live Classes',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ..._liveClasses,
            if (_pastClasses.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Past Classes',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ..._pastClasses,
          ],
        ),
      )),
    );
  }
}

class ClassTileWidget extends ConsumerWidget {
  final String name;
  bool live = false;
  final Timestamp date;
  final String id;

  ClassTileWidget({
    Key? key,
    required this.name,
    required this.live,
    required this.date,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _user = watch(currUserProvider).state;
    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundColor: live ? Colors.green : Colors.red,
        radius: 14,
      ),
      title: Text(name),
      subtitle: Text(
          '${DateFormat('yyyy-MM-dd – kk:mm').format(date.toDate())} \n${live.toString().toUpperCase()}'),
      trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScannerScreen(
                enrollNo: _user?.enrollmentnumber.toString() as String,
                name: _user?.name as String,
                classId: '5GWChdPRS1C9G5qXkpdM',
              ),
            ));
          },
          icon: Icon(Icons.qr_code_scanner)),
    );
  }
}
