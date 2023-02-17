import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/favorites.dart';


CollectionReference<favorites> getFavoritesMovieCollection() {
  return FirebaseFirestore.instance.collection('Favorite').withConverter(
    fromFirestore: (snapshot, options) => favorites.fromJson(snapshot.data()!),
    toFirestore: (value, options) => value.toJson(),
  );
}

Future<void> addFavoritesMovieToFireStore(favorites fav) {
  var collection = getFavoritesMovieCollection();
  var docRef = collection.doc();
  fav.id = docRef.id;
  return docRef.set(fav);
}

Stream<QuerySnapshot<favorites>> getFavoritesMovieFromFireStore(){
  return getFavoritesMovieCollection().
  where('isFavorite',isEqualTo:true).snapshots();

}
void deleteFavoritesMovieFromFirestore(String id){
  getFavoritesMovieCollection().doc(id).delete();
}
