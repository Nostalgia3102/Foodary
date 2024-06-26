
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/user_profile.dart';
import '../utils/utilities.dart';

class DatabaseServices {
  CollectionReference? _usersCollection;
  CollectionReference? _deliveryPersonalCollection;
  CollectionReference? _itemsCollection;
  CollectionReference? _notificationsCollection;
  CollectionReference? _ordersCollection;
  CollectionReference? _paymentHistoryCollection;
  CollectionReference? _promotionsCollection;
  CollectionReference? _reviewsCollection;
  CollectionReference? _vendorsCollection;


  DatabaseServices() {
    _setUpCollectionReferences();
  }

  void _setUpCollectionReferences() {
    _usersCollection =
        firebaseFirestore.collection("users").withConverter<UserProfile>(
            fromFirestore: (snapshots, _) => UserProfile.fromMap(
              snapshots.data()!,
            ),
            toFirestore: (user_profile, _) => user_profile.toMap());
  }

  // Future<void> createUserProfile({required UserProfile userProfile}) async {
  //   await _usersCollection?.doc(userProfile.uid).set(userProfile);
  // }
  //
  // Stream<QuerySnapshot<UserProfile>> getUserProfiles() {
  //   //to chat with own-self :
  //   // return _usersCollection?.where("uid").snapshots() as Stream<QuerySnapshot<UserProfile>>;
  //   return _usersCollection
  //       ?.where("uid", isNotEqualTo: authService.user!.uid)
  //       .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  // }
  //
  // Future<bool> checkChatExists(String uid1, String uid2) async {
  //   String chatID = generateChatId(uid1: uid1, uid2: uid2);
  //   final result = await _chatsCollection?.doc(chatID).get();
  //   if (result != null) {
  //     return result.exists;
  //   }
  //   return false;
  // }
  //
  // Stream getChatData(String uid1, String uid2) {
  //   String chatID = generateChatId(uid1: uid1, uid2: uid2);
  //   return _chatsCollection?.doc(chatID).snapshots()
  //   as Stream<DocumentSnapshot<Chat>>;
  // }
}