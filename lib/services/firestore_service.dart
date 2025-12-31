import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreService {
  final CollectionReference _productsCollection = 
      FirebaseFirestore.instance.collection('produits');

  // Ajouter un produit
  Future<void> addProduct(Product product) {
    return _productsCollection.add(product.toMap());
  }

  // Lire les produits en temps réel (Stream)
  Stream<List<Product>> getProducts() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}