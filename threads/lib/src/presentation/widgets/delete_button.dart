/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 10-07-2023 15:34:14
 * @modify date 10-07-2023 15:34:14
 * @desc [description]
 */
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onTap;
  const DeleteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.delete,
        color: Colors.grey,
      ),
    );
  }
}
