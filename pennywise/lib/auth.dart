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
        int initialOverallAmount = 0;
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'overall_amount': initialOverallAmount,
        });
        await _firestore.collection('budget_lists').doc(user.uid).set({
          'budget_list_ID': user.uid,
          'budget_items': [],
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
      //yeag this basically just gives us the user
      return userCredential.user;
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
