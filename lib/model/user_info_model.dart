import 'package:flutter/material.dart';

class UserDetails {
  UserDetails({
    @required this.uid,
    this.displayName = 'NITHian',
    this.rollNo = '*****',
    this.email,
    this.mobileNo = '+91-XXXXX-XXXXX',
    this.hostel = 'Aravali',
    this.year = 'First',
    this.branch = 'Architecture',
  });

  final String uid;
  String displayName;
  String rollNo;
  String email;
  String mobileNo;
  String hostel;
  String branch;
  String year;

  factory UserDetails.fromMap({Map<String, dynamic> value, String id}) {
    final UserDetails userDetail = UserDetails(
      uid: id,
      displayName: value['displayName'],
      rollNo: value['rollNo'],
      email: value['email'],
      mobileNo: value['mobileNo'],
      hostel: value['hostel'],
      branch: value['branch'],
      year: value['year'],
    );
    return userDetail;
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uid': this.uid,
        'displayName': this.displayName,
        'rollNo': this.rollNo,
        'email': this.email ?? '$rollNo@nith.ac.in',
        'mobileNo': this.mobileNo,
        'hostel': this.hostel,
        'branch': this.branch,
        'year': this.year,
      };

  void updateDisplayName(String displayName) =>
      updateWith(displayName: displayName);

  void updateRollNo(String rollNo) => updateWith(rollNo: rollNo);

  void updateMobileNo(String mobileNo) => updateWith(mobileNo: mobileNo);

  void updateHostel(String hostel) => updateWith(hostel: hostel);

  void updateBranch(String branch) => updateWith(branch: branch);

  void updateYear(String year) => updateWith(year: year);

  void updateWith({
    String displayName,
    String rollNo,
    String mobileNo,
    String hostel,
    String branch,
    String year,
  }) {
    this.displayName = displayName ?? this.displayName;
    this.rollNo = rollNo ?? this.rollNo;
    this.mobileNo = mobileNo ?? this.mobileNo;
    this.hostel = hostel ?? this.hostel;
    this.branch = branch ?? this.branch;
    this.year = year ?? this.year;
  }
}
