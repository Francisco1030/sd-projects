import 'package:flutter/material.dart';
import 'package:task/model/task.dart';
import 'package:task/service/api_service.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormTask extends StatefulWidget {
  Task task;

  FormTask({this.task});

  @override
  _FormTask createState() => _FormTask();
}

class _FormTask extends State<FormTask> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldDescriptionValid;
  TextEditingController _controllerDescription = TextEditingController();
  //bool _isFieldCompletedValid;
  //TextEditingController _controllerCompleted = TextEditingController();

  @override
  void initState() {
    if (widget.task != null) {
      _isFieldDescriptionValid = true;
      _controllerDescription.text = widget.task.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.task == null ? "Cadastrar Tarefa" : "Editar Tarefa",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldDescription(),
                // _buildTextFieldCompleted(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldDescriptionValid == null ||
                          !_isFieldDescriptionValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content:
                                Text("Por favor, preencha todos os campos"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String description =
                          _controllerDescription.text.toString();
                      Task task = Task(description: description);
                      if (widget.task == null) {
                        _apiService.createTask(task).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Falha no envio de dados"),
                            ));
                          }
                        });
                      } else {
                        task.id = widget.task.id;
                        _apiService.updateTask(task).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(
                                _scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Falha na atualização dos dados"),
                            ));
                          }
                        });
                      }
                    },
                    child: Text(
                      widget.task == null
                          ? "Cadastrar".toUpperCase()
                          : "Atualizar".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xFF8C8BEA),
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldDescription() {
    return TextField(
      controller: _controllerDescription,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Descrição",
        errorText: _isFieldDescriptionValid == null || _isFieldDescriptionValid
            ? null
            : "Preecha o campo",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDescriptionValid) {
          setState(() => _isFieldDescriptionValid = isFieldValid);
        }
      },
    );
  }

  // Widget _buildTextFieldCompleted() {
  //   return ListTile(
  //     controller: _controllerCompleted,
  //     //keyboardType: TextInputType.emailAddress,
  //     decoration: InputDecoration(
  //       labelText: "Status ",
  //       errorText: _isFieldCompletedValid == null || _isFieldCompletedValid
  //           ? null
  //           : "Email is required",
  //     ),
  //     onChanged: (value) {
  //       bool isFieldValid = value.trim().isNotEmpty;
  //       if (isFieldValid != _isFieldEmailValid) {
  //         setState(() => _isFieldEmailValid = isFieldValid);
  //       }
  //     },
  //   );
  // }

}
