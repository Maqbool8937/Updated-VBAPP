class BeggarRecord {
  final String id;
  final String fullName;
  final String? cnic;
  final String gender;
  final String beggaryType;
  final String captureLocation;
  final String captureDistrict;
  final String capturingAuthority;
  final String? photo;
  final String? biometric;
  final DateTime captureDateTime;
  final String? policeStation;
  final String? place;
  final String? age;
  final String? permanentAddress;
  final String? presentAddress;
  final String? originDistrict;
  final String? linkedMafia;
  final String? mafiaDetails;
  final String? previousRecord;
  final String? additionalNotes;
  final String? actionType;
  final String? firNo;
  final String? firPoliceStation;
  final String? organizationName;

  BeggarRecord({
    required this.id,
    required this.fullName,
    this.cnic,
    required this.gender,
    required this.beggaryType,
    required this.captureLocation,
    required this.captureDistrict,
    required this.capturingAuthority,
    this.photo,
    this.biometric,
    required this.captureDateTime,
    this.policeStation,
    this.place,
    this.age,
    this.permanentAddress,
    this.presentAddress,
    this.originDistrict,
    this.linkedMafia,
    this.mafiaDetails,
    this.previousRecord,
    this.additionalNotes,
    this.actionType,
    this.firNo,
    this.firPoliceStation,
    this.organizationName,
  });

  factory BeggarRecord.fromJson(Map<String, dynamic> json) {
    return BeggarRecord(
      id: json['_id'] ?? json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      cnic: json['cnic'],
      gender: json['gender'] ?? '',
      beggaryType: json['beggary_type'] ?? '',
      captureLocation: json['capture_location'] ?? '',
      captureDistrict: json['capture_district'] ?? '',
      capturingAuthority: json['capturing_authority'] ?? '',
      photo: json['photo'],
      biometric: json['biometric'],
      captureDateTime: json['capture_datetime'] != null
          ? DateTime.parse(json['capture_datetime'])
          : DateTime.now(),
      policeStation: json['police_station'],
      place: json['place'],
      age: json['age'],
      permanentAddress: json['permanent_address'],
      presentAddress: json['present_address'],
      originDistrict: json['origin_district'],
      linkedMafia: json['linked_mafia'],
      mafiaDetails: json['mafia_details'],
      previousRecord: json['previous_record'],
      additionalNotes: json['additional_notes'],
      actionType: json['action_type'],
      firNo: json['fir_no'],
      firPoliceStation: json['fir_police_station'],
      organizationName: json['organization_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'cnic': cnic,
      'gender': gender,
      'beggary_type': beggaryType,
      'capture_location': captureLocation,
      'capture_datetime': captureDateTime.toIso8601String(),
      'police_station': policeStation,
      'place': place,
      'age': age,
      'permanent_address': permanentAddress,
      'present_address': presentAddress,
      'origin_district': originDistrict,
      'linked_mafia': linkedMafia,
      'mafia_details': mafiaDetails,
      'previous_record': previousRecord,
      'additional_notes': additionalNotes,
      'action_type': actionType,
      'fir_no': firNo,
      'fir_police_station': firPoliceStation,
      'organization_name': organizationName,
    };
  }
}

