import 'package:flutter/material.dart';
import 'package:fyp/Models/NgoDeliveryService/DeliveryService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryServiceController {
  final CollectionReference deliveryService = FirebaseFirestore.instance.collection('deliveryService');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<String> addDeliveryService(DeliveryService deliveryService) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference deliveryServiceCollection = FirebaseFirestore.instance.collection('deliveryService');

      DocumentReference deliveryServiceReference = deliveryServiceCollection.doc();
      String deliveryServiceId = deliveryServiceReference.id;
      await deliveryServiceReference.set(deliveryService.toMap(deliveryServiceId));

      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateDeliveryStatus(String requestFoodId, String newStatus) async {
    try {
      DocumentReference docRef = firestore.collection('requestFood').doc(
          requestFoodId);

      await docRef.update({'status': newStatus});
      print('Delivery status updated successfully!');
    } catch (e) {
      print('Error updating delivery status: $e');
    }
  }

    Future<void> addDeliveryCollection(String requestFoodId, String status, String imageUrl) async {
      try {
        final documentReference = firestore.collection('requestFood').doc(requestFoodId);
        final DateTime now = DateTime.now();

        if (status == 'pickedUp') {
          final deliveryId = UniqueKey().toString(); // Generate a unique ID for the delivery
          final deliveryData = {
            'id': deliveryId,
            'datePicked': now,
            'dateDelivered': null,
            'proofOfDelivery':null,
          };

          await documentReference.update({
            'delivery_collection': [deliveryData],
          });
        } else if (status == 'delivered') {
          final snapshot = await documentReference.get();
          final existingDeliveryData = snapshot.data()?['delivery_collection'] ?? [];

          for (final deliveryData in existingDeliveryData) {
            deliveryData['dateDelivered'] = now;
            deliveryData['proofOfDelivery']= imageUrl;
          }

          await documentReference.update({
            'delivery_collection': existingDeliveryData,
          });
        }
      } catch (e) {
        print('Error updating delivery data: $e');
      }



      catch (e) {
        print('Error updating delivery status: $e');
        // );
      }
    }
  }

