class APIPath {
  static String event({String uid, String eventId}) =>
      'user/$uid/schedule/$eventId';
  static String events({String uid}) => 'user/$uid/schedule/';
  static String getUserInfo({String uid}) => 'user/$uid/';
  static String setUserInfo({String uid}) => 'user/$uid/';
  static String getAttendance({String rollNo}) => 'public/$rollNo/attendance';
}
