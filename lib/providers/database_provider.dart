import 'package:attendo/providers/firebaseProviders.dart';
import 'package:attendo/utils/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<FirestoreDatabase>((ref) {
  return FirestoreDatabase(ref.watch(firestoreDatabaseProvider)); 
});