import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicationsRecord extends FirestoreRecord {
  MedicationsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "med_name" field.
  String? _medName;
  String get medName => _medName ?? '';
  bool hasMedName() => _medName != null;

  // "dose" field.
  double? _dose;
  double get dose => _dose ?? 0.0;
  bool hasDose() => _dose != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  // "timing" field.
  String? _timing;
  String get timing => _timing ?? '';
  bool hasTiming() => _timing != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _medName = snapshotData['med_name'] as String?;
    _dose = castToType<double>(snapshotData['dose']);
    _completed = snapshotData['completed'] as bool?;
    _timing = snapshotData['timing'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('medications');

  static Stream<MedicationsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MedicationsRecord.fromSnapshot(s));

  static Future<MedicationsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MedicationsRecord.fromSnapshot(s));

  static MedicationsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MedicationsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MedicationsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MedicationsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MedicationsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MedicationsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMedicationsRecordData({
  String? uid,
  String? medName,
  double? dose,
  bool? completed,
  String? timing,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'med_name': medName,
      'dose': dose,
      'completed': completed,
      'timing': timing,
    }.withoutNulls,
  );

  return firestoreData;
}

class MedicationsRecordDocumentEquality implements Equality<MedicationsRecord> {
  const MedicationsRecordDocumentEquality();

  @override
  bool equals(MedicationsRecord? e1, MedicationsRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.medName == e2?.medName &&
        e1?.dose == e2?.dose &&
        e1?.completed == e2?.completed &&
        e1?.timing == e2?.timing;
  }

  @override
  int hash(MedicationsRecord? e) => const ListEquality()
      .hash([e?.uid, e?.medName, e?.dose, e?.completed, e?.timing]);

  @override
  bool isValidKey(Object? o) => o is MedicationsRecord;
}
