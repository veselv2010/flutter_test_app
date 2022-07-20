import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/models/comment.dart';
import 'package:im_good_test_app/core/domain/repositories/users_repository.dart';

class AddCommentDialog extends StatefulWidget {
  final int postId;
  const AddCommentDialog({Key? key, required this.postId}) : super(key: key);

  @override
  State<AddCommentDialog> createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  final UsersRepository repository = GetIt.I.get();

  late bool isLoading;
  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: 'name',
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'Your name'),
                validator: FormBuilderValidators.compose([
                  (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Must not be empty',
                ]),
              ),
              FormBuilderTextField(
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                  (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Must not be empty',
                ]),
              ),
              FormBuilderTextField(
                name: 'text',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 6,
                minLines: 3,
                decoration: InputDecoration(labelText: 'Comment'),
                validator: FormBuilderValidators.compose([
                  (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Must not be empty',
                ]),
              ),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      final isValid = _formKey.currentState?.validate();
                      if (isValid == true) {
                        setState(() {
                          isLoading = true;
                        });
                        _formKey.currentState!.save();
                        final value = _formKey.currentState!.value;
                        final comment = Comment(
                          id: 0,
                          postId: widget.postId,
                          name: value['name'],
                          email: value['email'],
                          body: value['email'],
                        );
                      }
                    },
                    child: const Text('Send comment'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
