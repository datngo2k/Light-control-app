import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:light_controller_app/constant/constant.dart';

class CustomDropDownButton extends StatefulWidget {
  final List listItem;
  final TextEditingController textController;
  CustomDropDownButton({this.listItem, this.textController});
  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  var dropdownValue;
  @override
  void initState() {
    dropdownValue = widget.listItem[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
       searchBoxController: widget.textController, 
        mode: Mode.MENU,
        showSelectedItem: true,
        items: widget.listItem,
        popupItemDisabled: (String s) => s.startsWith('I'),
        onChanged: print,
        selectedItem: widget.listItem[0]);
  }
}
