import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PatientDoctorRecord extends FirestoreRecord {
  PatientDoctorRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "doctorid" field.
  String? _doctorid;
  String get doctorid => _doctorid ?? '';
  bool hasDoctorid() => _doctorid != null;

  // "patientid" field.
  String? _patientid;
  String get patientid => _patientid ?? '';
  bool hasPatientid() => _patientid != null;

  void _initializeFields() {
    _doctorid = snapshotData['doctorid'] as String?;
    _patientid = snapshotData['patientid'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('patient_doctor');

  static Stream<PatientDoctorRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PatientDoctorRecord.fromSnapshot(s));

  static Future<PatientDoctorRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PatientDoctorRecord.fromSnapshot(s));

  static PatientDoctorRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PatientDoctorRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PatientDoctorRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PatientDoctorRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PatientDoctorRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PatientDoctorRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPatientDoctorRecordData({
  String? doctorid,
  String? patientid,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'doctorid': doctorid,
      'patientid': patientid,
    }.withoutNulls,
  );

  return firestoreData;
}

class PatientDoctorRecordDocumentEquality
    implements Equality<PatientDoctorRecord> {
  const PatientDoctorRecordDocumentEquality();

  @override
  bool equals(PatientDoctorRecord? e1, PatientDoctorRecord? e2) {
    return e1?.doctorid == e2?.doctorid && e1?.patientid == e2?.patientid;
  }

  @override
  int hash(PatientDoctorRecord? e) =>
      const ListEquality().hash([e?.doctorid, e?.patientid]);

  @override
  bool isValidKey(Object? o) => o is PatientDoctorRecord;
}
