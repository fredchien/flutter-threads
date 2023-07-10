/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 10-07-2023 15:34:11
 * @modify date 10-07-2023 15:34:11
 * @desc [description]
 */
import 'package:flutter/material.dart';

class CommentButton extends StatelessWidget {
  final void Function()? onTap;
  const CommentButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.comment,
          color: Colors.grey,
        ));
  }
}
