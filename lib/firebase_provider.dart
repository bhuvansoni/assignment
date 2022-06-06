import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  Future<List<DocumentSnapshot>> fetchFirstList() async {
    return (await FirebaseFirestore.instance
            .collection("users")
            .limit(10)
            .get())
        .docs;
  }

  Future<List<DocumentSnapshot>> fetchNextList(
      List<DocumentSnapshot> documentList) async {
    return (await FirebaseFirestore.instance
            .collection("users")
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(10)
            .get())
        .docs;
  }

  Future<List<DocumentSnapshot>> searchUser(String query) async {
    return (await FirebaseFirestore.instance
            .collection("users")
            .where('name',
                isGreaterThanOrEqualTo: query,
                isLessThan: query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
            .get())
        .docs;
  }

  Future<List<DocumentSnapshot>> searchMoreUsers(
      List<DocumentSnapshot> documentList, String query) async {
    print(query.substring(0, query.length - 1) +
        String.fromCharCode(query.codeUnitAt(query.length - 1) + 1));
    return (await FirebaseFirestore.instance
            .collection("users")
            .where('name',
                isGreaterThanOrEqualTo: query,
                isLessThan: query.substring(0, query.length - 1) +
                    String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(10)
            .get())
        .docs;
  }

  filterUsers(int start, int end) async {
    return (await FirebaseFirestore.instance
            .collection("users")
            .where('age',
                isGreaterThanOrEqualTo: start, isLessThanOrEqualTo: end)
            .limit(10)
            .get())
        .docs;
  }
}
