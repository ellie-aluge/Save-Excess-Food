import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DeliveryService {
  CollectionReference surplus = FirebaseFirestore.instance.collection('deliveryService');
  String? stakeholderId;
  bool? availabilityStatus;
  String? vehicleId;

  DeliveryService({
    this.stakeholderId,
    this.availabilityStatus,
    this.vehicleId,
  });

  // Receiving data from the server
  factory DeliveryService.fromMap(map) {
    return DeliveryService(
      stakeholderId: map['stakeholderId'],
      availabilityStatus: map['availabilityStatus'],
      vehicleId: map['vehicleId'],
    );
  }

  void addDeliveryService(String? stakeholderId) async {
    await FirebaseFirestore.instance.collection('deliveryService').doc(stakeholderId).set({
      'stakeholderId': stakeholderId,
      'availabilityStatus': availabilityStatus,
      'vehicleId': vehicleId,
    });
  }

  // Sending data to our server
  Map<String, dynamic> toMap(String? stakeholderId) {
    print(stakeholderId);
    return {
      'stakeholderId': stakeholderId,
      'availabilityStatus': availabilityStatus,
      'vehicleId': vehicleId,
    };
  }
}
