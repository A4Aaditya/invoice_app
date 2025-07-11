import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:invoice_app/model/property.dart';
import 'package:invoice_app/utils/extensions.dart';
import 'package:invoice_app/widgets/properrty_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyListingScreen extends StatelessWidget {
  const PropertyListingScreen({super.key});

  Future<List<Map<String, dynamic>>> fetch() async =>
      Supabase.instance.client.from('properties').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Property')),
      body: FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          return switch (snapshot.connectionState) {
            ConnectionState.none => Text('none'),
            ConnectionState.waiting => Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.white,
                size: 80,
              ),
            ),
            ConnectionState.active => Text('active'),
            ConnectionState.done => RefreshIndicator(
              onRefresh: fetch,
              child: ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final json = jsonEncode(snapshot.data?[index]);
                  final property = Property.fromJson(jsonDecode(json));
                  return PropertyCard(property: property);
                },
              ),
            ),
          };
        },
      ),
    );
  }
}
