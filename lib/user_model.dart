class UserModel {
  String id;
  String name;
  String gender;
  DateTime dob;
  DateTime createdAt;
  String profession;
  String placeOfWork;
  String placeOfEdu;
  String academicCourse;
  String bio;
  String email;
  String inJumpinFor;
  Map<String, dynamic> geoPoint;
  List<String> interestList;
  List<String> photoList;
  // List<UserContact> contacts;
  List<String> connections;
  List<String> plans;
  String phoneNo;
  String searchUname;
  Map<String, dynamic> favourites;
  int unseenTotalCount;
  bool isOnline;
  String geohash;
  Map<String, dynamic> location;

  UserModel(
    this.id,
    this.name,
    this.gender,
    this.dob,
    this.createdAt,
    this.profession,
    this.placeOfWork,
    this.placeOfEdu,
    this.academicCourse,
    this.bio,
    this.email,
    this.inJumpinFor,
    this.geoPoint,
    this.interestList,
    this.photoList,
    // this.contacts,
    this.connections,
    this.plans,
    this.phoneNo,
    this.searchUname,
    this.favourites,
    this.unseenTotalCount,
    this.isOnline,
    this.geohash,
    this.location,
  );
}
