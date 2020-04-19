
import 'package:balance_app/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Custom implementation of a two-way toggle button
class CustomToggleButton extends StatefulWidget {
  final Text leftText;
  final Text rightText;
  final SelectedToggle selected;
  final ValueChanged<SelectedToggle> onChanged;

  CustomToggleButton({
    this.leftText,
    this.rightText,
    this.selected,
    this.onChanged,
  });

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

/// Enum that identify which toggle button is pressed
enum SelectedToggle { left, right }

class _CustomToggleButtonState extends State<CustomToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(SelectedToggle.left),
          _buildButton(SelectedToggle.right),
        ],
      ),
    );
  }

  BorderRadius _getBorderRadiusForButton(SelectedToggle position, BorderRadius themeRadius) {
    return position == SelectedToggle.left
      ? BorderRadius.horizontal(left: themeRadius.topLeft)
      : BorderRadius.horizontal(right: themeRadius.topRight);
  }

  Widget _buildButton(SelectedToggle buttonPosition) {
    bool isSelected = widget.selected == buttonPosition;
    ToggleButtonsThemeData toggleTheme = Theme.of(context).toggleButtonsTheme;

    BorderRadius themeBorderRadius = toggleTheme.borderRadius ?? BorderRadius.all(Radius.circular(0.0));
    Color borderColor = isSelected? toggleTheme.fillColor: toggleTheme.borderColor;
    double borderWidth = toggleTheme.borderWidth ?? 1.0;

    return Material(
      borderRadius: _getBorderRadiusForButton(buttonPosition, themeBorderRadius),
      color: isSelected
        ? toggleTheme.fillColor
        : BColors.colorSecondary,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
            bottom: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
            right: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
            left: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
          borderRadius: _getBorderRadiusForButton(buttonPosition, themeBorderRadius),
          color: Colors.transparent,
        ),
        child: InkWell(
          onTap: () {
            if (widget.selected != buttonPosition)
              widget.onChanged(buttonPosition);
          },
          borderRadius: _getBorderRadiusForButton(buttonPosition, themeBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: DefaultTextStyle.merge(
              child: buttonPosition == SelectedToggle.left
                ? widget.leftText
                : widget.rightText,
              style: Theme.of(context).textTheme.button.copyWith(
                color: isSelected
                  ? toggleTheme.selectedColor
                  : toggleTheme.color
              )
            ),
          ),
        ),
      ),
    );
  }
}
