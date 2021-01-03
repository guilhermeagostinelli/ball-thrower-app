import 'package:ball_thrower_app/Enums/Speed.dart';
import 'package:flutter/material.dart';

class SpeedSelector extends StatelessWidget {
  const SpeedSelector({
    @required this.title,
    @required this.speed,
    @required this.speedChanged,
    Key key,
  }) : super(key: key);

  final String title;
  final Speed speed;
  final void Function(Speed newSpeed) speedChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double speedOptionSize = (constraints.maxWidth - 4) / 3;
        return Column(
          children: [
            const SizedBox(height: 60),
            Text(title),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _SpeedOption.low(
                  width: speedOptionSize,
                  isSelected: speed == Speed.LOW,
                  onTap: () => speedChanged(Speed.LOW),
                ),
                const SizedBox(width: 2),
                _SpeedOption.medium(
                  width: speedOptionSize,
                  isSelected: speed == Speed.MEDIUM,
                  onTap: () => speedChanged(Speed.MEDIUM),
                ),
                const SizedBox(width: 2),
                _SpeedOption.high(
                  width: speedOptionSize,
                  isSelected: speed == Speed.HIGH,
                  onTap: () => speedChanged(Speed.HIGH),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _SpeedOption extends StatelessWidget {
  const _SpeedOption.low({
    @required this.width,
    @required this.isSelected,
    @required this.onTap,
    Key key,
  })  : this.height = 40,
        super(key: key);

  const _SpeedOption.medium({
    @required this.width,
    @required this.isSelected,
    @required this.onTap,
    Key key,
  })  : this.height = 80,
        super(key: key);

  const _SpeedOption.high({
    @required this.width,
    @required this.isSelected,
    @required this.onTap,
    Key key,
  })  : this.height = 120,
        super(key: key);

  final double width;
  final double height;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
