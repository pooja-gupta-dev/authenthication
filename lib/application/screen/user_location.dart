
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class LocationScreen extends StatelessWidget {
  final String userId;
  const LocationScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: Text('Current Locations',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('')
            .doc(userId)
            .collection('locations')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var locations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              var location = locations[index];
              return Container(
                height: 210, // Set the desired height for the card
                margin: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Latitude: ${location['latitude']}'),
                        Text('Longitude: ${location['longitude']}'),
                        Text('Address: ${location['address']}'),
                        Text('Locality: ${location['locality']}'),
                        Text('Sub Administrative Area: ${location['subAdministrativeArea']}'),
                        Text('Administrative Area: ${location['administrativeArea']}'),
                        Text('Postal Code: ${location['postalCode']}'),
                        Text('Country: ${location['country']}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}