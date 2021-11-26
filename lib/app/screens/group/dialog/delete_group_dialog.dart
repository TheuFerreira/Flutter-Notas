import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteGroupDialog {
  Future<bool> show(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.black,
              ),
              SizedBox(width: 8.0),
              Text('Confirmação de Exlusão'),
            ],
          ),
          content: Text(
              'Tem certeza de que deseja excluir o(s) grupo(s) selecionado(s)?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Confirmar',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancelar'),
              style: TextButton.styleFrom(backgroundColor: Colors.black),
            ),
          ],
        );
      },
    );
    if (result == null) return false;

    return result;
  }
}
