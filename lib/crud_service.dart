import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class PickedImage {
  final File file;
  final String url;
  PickedImage({required this.file, required this.url});
}

class CrudService {
  final CollectionReference items = FirebaseFirestore.instance.collection(
    'items',
  );

  Future<void> addItem(String name, int quantity) {
    //CREATE
    return items.add({
      'name': name,
      'quantity': quantity,
      'createdAt': Timestamp.now(),
      'is_favorite': false,
    });
  }

  //READ
  Stream<QuerySnapshot> getItems() {
    return items.orderBy('createdAt', descending: true).snapshots();
  }

  //UPDATE
  Future<void> updateItem(String id, String name, int quantity) {
    return items.doc(id).update({'name': name, 'quantity': quantity});
  }

  //TOGGLE FAVORITE
  Future<void> toggleFavorite(String id, bool currentStatus) {
    return items.doc(id).update({'is_favorite': !currentStatus});
  }

  //DELETE
  Future<void> deleteItem(String id) {
    return items.doc(id).delete();
  }
}
