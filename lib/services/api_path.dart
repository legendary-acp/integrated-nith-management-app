class APIPath{
  static String event({String uid, String eventId}) => 'user/$uid/schedule/$eventId';
  static String events({String uid}) => 'user/$uid/schedule/';

}