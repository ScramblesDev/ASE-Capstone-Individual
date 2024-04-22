import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Initialize overall_amount as 0 for a new user
        int initialOverallAmount = 0;
        // Create a document in 'users' collection with user's UID
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'overall_amount': initialOverallAmount,
        });
        // Create a corresponding budget_list for the user in 'budget_lists' collection
        // This creates a new document with the user's UID as the budget_list_ID
        await _firestore.collection('budget_lists').doc(user.uid).set({
          'budget_list_ID': user.uid,
          'budget_items': [], // Initialize with an empty list of budget items
        });
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign up: ${e.message}');
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // This returns the user
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to sign in: ${e.message}');
    }
  }

  Future<void> updateOverallAmount(String userId, int newAmount) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .update({'overall_amount': newAmount});
  }

  Future<void> addBudgetItem(
      String userId, String budgetName, int budgetGoal) async {
    DocumentReference budgetListRef =
        _firestore.collection('budget_lists').doc(userId);
    Map<String, dynamic> newItem = {
      'budget_name': budgetName,
      'budget_goal': budgetGoal
    };

    await budgetListRef.update({
      'budget_items': FieldValue.arrayUnion([newItem])
    });
  }
}
