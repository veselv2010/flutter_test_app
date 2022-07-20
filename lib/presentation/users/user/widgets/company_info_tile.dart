import 'package:flutter/material.dart';
import 'package:im_good_test_app/core/domain/models/user.dart';

class CompanyInfoTile extends StatelessWidget {
  final Company company;
  const CompanyInfoTile({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Working at ${company.name}'),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(company.bs),
          Text(
            company.catchPhrase,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
