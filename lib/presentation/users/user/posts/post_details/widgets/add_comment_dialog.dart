import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:im_good_test_app/core/domain/repositories/posts_repository.dart';

/// Returns [true] or [false] after commment saving
class AddCommentDialog extends StatefulWidget {
  final int postId;
  const AddCommentDialog({Key? key, required this.postId}) : super(key: key);

  @override
  State<AddCommentDialog> createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  final PostsRepository repository = GetIt.I.get();

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
                decoration: const InputDecoration(labelText: 'Your name'),
                validator: FormBuilderValidators.compose([
                  (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Must not be empty',
                ]),
              ),
              FormBuilderTextField(
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.email(),
                  (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Must not be empty',
                ]),
              ),
              FormBuilderTextField(
                name: 'body',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 6,
                minLines: 3,
                decoration: const InputDecoration(labelText: 'Comment'),
                validator: FormBuilderValidators.compose([
                  (value) => value != null && value.isNotEmpty
                      ? null
                      : 'Must not be empty',
                ]),
              ),
              if (isLoading)
                const SizedBox(
                  height: 54,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: sendComment,
                    child: const Text('Send comment'),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendComment() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      final value = _formKey.currentState!.value;
      final res = await repository.sendComment(
        email: value['email'],
        name: value['name'],
        body: value['body'],
        postId: widget.postId,
      );

      if (mounted) {
        AutoRouter.of(context).pop(res);
      }
    }
  }
}
