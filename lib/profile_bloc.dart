import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'firebase_provider.dart';

class UserListBloc {
  FirebaseProvider firebaseProvider = FirebaseProvider();
  bool isFiltered = false;
  bool isSearched = false;

  bool showIndicator = false;
  late List<DocumentSnapshot> documentList;
  late List<DocumentSnapshot> searchList;
  late List<DocumentSnapshot> filterList;

  BehaviorSubject<List<DocumentSnapshot>> movieController =
      BehaviorSubject<List<DocumentSnapshot>>();
  BehaviorSubject<List<DocumentSnapshot>> searchController =
  BehaviorSubject<List<DocumentSnapshot>>();
  BehaviorSubject<List<DocumentSnapshot>> filterController =
  BehaviorSubject<List<DocumentSnapshot>>();

  BehaviorSubject<bool> showIndicatorController = BehaviorSubject<bool>();
  BehaviorSubject<bool> isFilteredController = BehaviorSubject<bool>();
  BehaviorSubject<bool> isSearchedController = BehaviorSubject<bool>();
  Stream get getIsFiltered => isFilteredController.stream;
  Stream get getIsSearched => isSearchedController.stream;
  Stream get getShowIndicatorStream => showIndicatorController.stream;



  Stream<List<DocumentSnapshot>> get movieStream => movieController.stream;
  Stream<List<DocumentSnapshot>> get searchStream => searchController.stream;
  Stream<List<DocumentSnapshot>> get filterStream => filterController.stream;

/*This method will automatically fetch first 10 elements from the document list */
  Future fetchFirstList() async {
    try {
      documentList = await firebaseProvider.fetchFirstList();
      print(documentList);
      movieController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          movieController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      movieController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      movieController.sink.addError(e);
    }
  }

  searchUsers(String name) async {
    try {
      updateIndicator(true);

      List<DocumentSnapshot> newDocumentList =
          await firebaseProvider.searchUser(name);
      documentList.clear();
      documentList.addAll(newDocumentList);
      movieController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          movieController.sink.addError("No Data Available");
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
      }
    } on SocketException {
      movieController.sink.addError(SocketException("No Internet Connection"));
      updateIndicator(false);
    } catch (e) {
      updateIndicator(false);
      print(e.toString());
      movieController.sink.addError(e);
    }
  }

  searchUsersNext(String name) async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
      await firebaseProvider.searchUser(name);
      documentList.clear();
      documentList.addAll(newDocumentList);
      movieController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          movieController.sink.addError("No Data Available");
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
      }
    } on SocketException {
      movieController.sink.addError(SocketException("No Internet Connection"));
      updateIndicator(false);
    } catch (e) {
      updateIndicator(false);
      print(e.toString());
      movieController.sink.addError(e);
    }
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextMovies() async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
          await firebaseProvider.fetchNextList(documentList);
      documentList.addAll(newDocumentList);
      movieController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          movieController.sink.addError("No Data Available");
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
      }
    } on SocketException {
      movieController.sink.addError(SocketException("No Internet Connection"));
      updateIndicator(false);
    } catch (e) {
      updateIndicator(false);
      print(e.toString());
      movieController.sink.addError(e);
    }
  }

/*For updating the indicator below every list and paginate*/
  updateIndicator(bool value) async {
    showIndicator = value;
    showIndicatorController.sink.add(value);
  }

  updateFiltered(bool value) async {
    isFiltered = value;
    isFilteredController.sink.add(value);
  }

  updateSearched(bool value) async {
    isSearched = value;
    isSearchedController.sink.add(value);
  }

  void dispose() {
    movieController.close();
    showIndicatorController.close();
  }
}
