import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogService {
  Future<dynamic> showAlertDialog(
    BuildContext context,
    String title,
    String description,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
