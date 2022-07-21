import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';

class AddressInfoTile extends StatelessWidget {
  final Address address;
  const AddressInfoTile({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Address'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              '${address.city} ${address.street} ${address.zipcode} ${address.suite}'),
        ],
      ),
    );
  }
}
