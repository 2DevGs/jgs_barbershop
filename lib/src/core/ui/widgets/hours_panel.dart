import 'package:flutter/material.dart';

import 'package:jgs_barbershop/src/core/ui/constants.dart';

class HoursPanel extends StatelessWidget {
  final List<int>? enabledTimes;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;

  const HoursPanel({
    super.key,
    this.enabledTimes,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecione os horários de atendimento',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(
                enabledTimes: enabledTimes,
                label: '${i.toString().padLeft(2, '0')}:00',
                onPressed: onHourPressed,
                value: i,
              ),
          ],
        ),
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final List<int>? enabledTimes;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;

  const TimeButton({
    super.key,
    this.enabledTimes,
    required this.label,
    required this.value,
    required this.onPressed,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor = selected
        ? ColorsConstants.brow
        : ColorsConstants.grey;

    final TimeButton(:value, :label, :enabledTimes, :onPressed) = widget;
    
    final disabledTime = enabledTimes != null && !enabledTimes.contains(value);

    if(disabledTime) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disabledTime ? null : () {
        setState(() {
          selected = !selected;
          onPressed(value);
        });
      },
      child: Container(
        width: 64,
        height: 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(color: buttonBorderColor),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
