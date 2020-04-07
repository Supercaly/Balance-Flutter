
import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:balance_app/res/colors.dart';

/// Widget that contains and manage a group of [CheckboxElement]s
/// 
/// This Widget instantiates a list of [CheckboxElement]s
/// based on the given [labels]s.
/// Using a [GlobalKey] of [CheckboxGroupState] its possible
/// to call the [CheckboxGroupState.selected] getter to obtain
/// the selected elements.
class CheckboxGroup extends StatefulWidget {
  final List<String> labels;

  CheckboxGroup({
    Key key,
    this.labels,
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => CheckboxGroupState();
}

/// State of [CheckboxGroupState]
class CheckboxGroupState extends State<CheckboxGroup> {
  List<GlobalKey<_CheckboxElementState>> _keys;
  
  @override
  void initState() {
    super.initState();
    _keys = [];
    widget.labels.forEach((_) => _keys.add(GlobalKey<_CheckboxElementState>()));
  }

  @override
  void dispose() {
    super.dispose();
    _keys = null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.labels.map((e) {
        final idx = widget.labels.indexOf(e);
        return CheckboxElement(key: _keys[idx],label: e);
      }).toList()
    );
  }

  /// Returns a list of length equal to the number of labels where
  /// each elements is true or false if it's selected.
  List<bool> get selected => _keys.map((key) => key.currentState.isSelected).toList();
}

/// A single checkbox element
class CheckboxElement extends StatefulWidget {
  final String label;

  CheckboxElement({
    Key key,
    @required this.label,
  }): assert(label != null),
    super(key: key);

  @override
  _CheckboxElementState createState() => _CheckboxElementState();
}

class _CheckboxElementState extends State<CheckboxElement> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        borderRadius: BorderRadius.circular(9),
        color: isSelected? Color(0xFFF3F3FF): Colors.white,
        elevation: isSelected? 8: 4,
        child: InkWell(
          onTap: () {
            setState(() => isSelected = !isSelected);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: <Widget>[
                CircularCheckBox(
                  activeColor: BColors.colorPrimary,
                  inactiveColor: Color(0xFFBFBFBF),
                  checkColor: Color(0xFFF3F3FF),
                  value: isSelected,
                  onChanged: (value) {
                    setState(() => isSelected = value);
                  },
                ),
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: isSelected? BColors.colorPrimary: Color(0xFFBFBFBF),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
