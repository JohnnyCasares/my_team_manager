import 'package:flutter/material.dart';

import '../../constants/soccer.dart';
import '../../custom widgets/my_text_field.dart';

class PlayerData extends StatefulWidget {
  const PlayerData(
      {super.key,
      required this.nameController,
      required this.positionController,
      required this.positions});
  final TextEditingController nameController;
  final TextEditingController positionController;
  final Function(Map<String, String>) positions;

  @override
  State<PlayerData> createState() => _PlayerDataState();
}

class _PlayerDataState extends State<PlayerData> {
  Map<String, String> myPositions = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const Center(child: Text("Player Info")),
        MyTextField(
          hint: 'Enter your name',
          icon: Icons.text_fields,
          controller: widget.nameController,
        ),

        //Positions
        MyTextField(
          controller: widget.positionController,
          hint: 'Select your preferred position',
          icon: Icons.directions_run,
          readOnly: true,
          function: () async {
            myPositions = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const PositionDialogSelection();
                });
            //Get positions selected by user and populate text box with it
            List<String> positionList = myPositions.keys.toList();
            String positionText = positionList.toString();
            positionText = positionText.substring(1, positionText.length - 1);
            widget.positionController.text = positionText;
            //Return positions through functions
            widget.positions(myPositions);
          },
        ),
      ],
    ));
  }
}

class PositionDialogSelection extends StatefulWidget {
  const PositionDialogSelection({super.key});

  @override
  State<PositionDialogSelection> createState() =>
      _PositionDialogSelectionState();
}

class _PositionDialogSelectionState extends State<PositionDialogSelection> {
  static Map<String, String> userSelection = {};
  @override
  Widget build(BuildContext context) {
    //popup dialog box

    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Choose your preferred position'),
                  const SizedBox(height: 15),
                  Position(
                    positionTitle: 'Attack',
                    positionOptions: Soccer.attack,
                    userPicks: (String position, String fullName) {
                      setState(() {
                        userSelection.addAll({position: fullName});
                      });
                    },
                  ),
                  const Divider(),
                  Position(
                    positionTitle: 'Midfield',
                    positionOptions: Soccer.midField,
                    userPicks: (String position, String fullName) {
                      setState(() {
                        userSelection.addAll({position: fullName});
                      });
                    },
                  ),
                  const Divider(),
                  Position(
                    positionTitle: 'Defense',
                    positionOptions: Soccer.defense,
                    userPicks: (String position, String fullName) {
                      setState(() {
                        userSelection.addAll({position: fullName});
                      });
                    },
                  ),
                  const Divider(),

                  //
                  Position(
                    positionTitle: 'Preference',
                    positionOptions: userSelection,
                    preference: true,
                    userPicks: (String position, String fullName) {
                      print("removed $position ($fullName)");
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, userSelection);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Position extends StatefulWidget {
  const Position(
      {super.key,
      required this.positionOptions,
      required this.positionTitle,
      this.preference,
      required this.userPicks});
  final String positionTitle;
  final Map<String, String> positionOptions;
  final bool? preference;
  final Function(String, String) userPicks;

  @override
  State<Position> createState() => _PositionState();
}

class _PositionState extends State<Position> {
  Map<String, String> preferredPositions =
      _PositionDialogSelectionState.userSelection;

  @override
  Widget build(BuildContext context) {
    bool preference = widget.preference ?? false;
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: PositionTitle(
            positionTitle: widget.positionTitle,
            onPositionSelected: (value) {
              setState(() {
                if (preferredPositions.containsKey(value)) {
                  widget.userPicks(value, value);
                  if (preference) {
                    preferredPositions.remove(value);
                  }
                } else {
                  if (!preference) {
                    preferredPositions.addAll({value: value});
                    widget.userPicks(value, value);
                  }
                }
              });
            },
          ),
        ),
        Expanded(
          child: Wrap(
            children: List<Widget>.generate(widget.positionOptions.keys.length,
                (index) {
              final key = widget.positionOptions.keys.elementAt(index);
              final value = widget.positionOptions.values.elementAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PositionItem(
                  position: key,
                  positionFullName: value,
                  onPositionSelected: (position, positionFullName) {
                    setState(() {
                      if (preferredPositions.containsKey(position)) {
                        widget.userPicks(position, positionFullName);
                        if (preference) {
                          preferredPositions.remove(position);
                        }
                      } else {
                        preferredPositions.addAll({position: positionFullName});
                        widget.userPicks(position, positionFullName);
                      }
                    });
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class PositionItem extends StatelessWidget {
  const PositionItem(
      {super.key,
      required this.position,
      required this.positionFullName,
      this.noReturn,
      required this.onPositionSelected});
  final String position;
  final String positionFullName;
  final bool? noReturn;
  final Function(String, String) onPositionSelected;
  // final VoidCallback selection;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: positionFullName,
      child: ElevatedButton(
        onPressed: () => onPositionSelected(position, positionFullName),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(position),
        ),
      ),
    );
  }
}

class PositionTitle extends StatelessWidget {
  const PositionTitle(
      {super.key,
      required this.positionTitle,
      this.noReturn,
      required this.onPositionSelected});
  final String positionTitle;
  final bool? noReturn;
  final Function(String) onPositionSelected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPositionSelected(positionTitle),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(positionTitle),
        ));
  }
}
