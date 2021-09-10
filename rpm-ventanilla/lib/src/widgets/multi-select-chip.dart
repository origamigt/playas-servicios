import 'package:flutter/material.dart';
import 'package:playas/src/models/data.dart';

class MultiSelectChip extends StatefulWidget {
  final List<Data>? reportList;
  final Function(Data)? onSelectionChanged; // +added
  MultiSelectChip(this.reportList, {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // this function will build and return the choice list
  _buildChoiceList() {
    Data? selectedChoice;
    List<Widget> choices = [];
    widget.reportList!.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(
            item.data!,
            style: Theme.of(context).textTheme.headline5,
          ),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = (selected ? item : null)!;
              //selectedChoice = item;
              widget.onSelectionChanged!(selectedChoice!); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
