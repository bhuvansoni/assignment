import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

import 'firebase_provider.dart';

class ProfileController extends GetxController {
  FirebaseProvider firebaseProvider = FirebaseProvider();
  final profiles = List<DocumentSnapshot>.empty(growable: true).obs;
  final showIndicator = false.obs;
  final searchProfiles = <DocumentSnapshot>[].obs;
  final filterProfiles = <DocumentSnapshot>[].obs;
  final start = 16.obs, end = 80.obs;
  final status = 0.obs;
//  status 0 for normal
//  status 1 for search
//  status 2 for filter

  void onInit() {
    fetchFirstList();
    super.onInit();
  }

  Future fetchFirstList() async {
    showIndicator(true);
    profiles.value = await firebaseProvider.fetchFirstList();
    showIndicator(false);
  }

  void clearSearch() {
    status(0);
    searchProfiles.value = [];
  }

  searchUsers(String name) async {
    if (name.isEmpty) {
      clearSearch();
      return;
    }
    status(1);
    showIndicator(true);
    print(name);
    List<DocumentSnapshot> newDocumentList =
        await firebaseProvider.searchUser(name);
    print(newDocumentList.length);
    searchProfiles.clear();
    searchProfiles.value = newDocumentList;
    showIndicator(false);
  }

  clearFilter() {
    status(1);
    filterProfiles.value = [];
  }

  filterUsers() async {
    status(2);
    showIndicator(true);
    List<DocumentSnapshot> newDocumentList =
        await firebaseProvider.filterUsers(start.value, end.value);
    filterProfiles.value = newDocumentList;
    showIndicator(false);
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextMovies() async {
    List<DocumentSnapshot> newDocumentList =
        await firebaseProvider.fetchNextList(profiles);
    profiles.addAll(newDocumentList);
  }
}
