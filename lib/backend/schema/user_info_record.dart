import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserInfoRecord extends FirestoreRecord {
  UserInfoRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "primary_diagnosis" field.
  String? _primaryDiagnosis;
  String get primaryDiagnosis => _primaryDiagnosis ?? '';
  bool hasPrimaryDiagnosis() => _primaryDiagnosis != null;

  // "secondary_diagnosis" field.
  String? _secondaryDiagnosis;
  String get secondaryDiagnosis => _secondaryDiagnosis ?? '';
  bool hasSecondaryDiagnosis() => _secondaryDiagnosis != null;

  // "age" field.
  int? _age;
  int get age => _age ?? 0;
  bool hasAge() => _age != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _primaryDiagnosis = snapshotData['primary_diagnosis'] as String?;
    _secondaryDiagnosis = snapshotData['secondary_diagnosis'] as String?;
    _age = castToType<int>(snapshotData['age']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_info');

  static Stream<UserInfoRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserInfoRecord.fromSnapshot(s));

  static Future<UserInfoRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserInfoRecord.fromSnapshot(s));

  static UserInfoRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserInfoRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserInfoRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserInfoRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserInfoRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserInfoRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserInfoRecordData({
  String? uid,
  String? displayName,
  String? primaryDiagnosis,
  String? secondaryDiagnosis,
  int? age,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'display_name': displayName,
      'primary_diagnosis': primaryDiagnosis,
      'secondary_diagnosis': secondaryDiagnosis,
      'age': age,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserInfoRecordDocumentEquality implements Equality<UserInfoRecord> {
  const UserInfoRecordDocumentEquality();

  @override
  bool equals(UserInfoRecord? e1, UserInfoRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.displayName == e2?.displayName &&
        e1?.primaryDiagnosis == e2?.primaryDiagnosis &&
        e1?.secondaryDiagnosis == e2?.secondaryDiagnosis &&
        e1?.age == e2?.age;
  }

  @override
  int hash(UserInfoRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.displayName,
        e?.primaryDiagnosis,
        e?.secondaryDiagnosis,
        e?.age
      ]);

  @override
  bool isValidKey(Object? o) => o is UserInfoRecord;
}
