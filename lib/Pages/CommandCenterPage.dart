import 'package:ball_thrower_app/Enums/Speed.dart';
import 'package:ball_thrower_app/Notifiers/CommandCenterNotifier.dart';
import 'package:ball_thrower_app/UI/SpeedSelector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommandCenterPage extends StatefulWidget {
  @override
  _CommandCenterPageState createState() => _CommandCenterPageState();
}

class _CommandCenterPageState extends State<CommandCenterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<CommandCenterNotifier>().connectToServer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ball Thrower'),
      ),
      body: context.select<CommandCenterNotifier, bool>((c) => c.serverOn)
          ? getMainUI(context)
          : getLoaderUI(),
    );
  }

  SingleChildScrollView getMainUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SwitchListTile(
              title: Text('Turn on/off:'),
              value: context.select<CommandCenterNotifier, bool>(
                (c) => c.ballThrowerOn,
              ),
              onChanged: (isOn) =>
                  context.read<CommandCenterNotifier>().ballThrowerOn = isOn,
            ),
            Opacity(
              opacity: context.select<CommandCenterNotifier, bool>(
                (c) => c.ballThrowerOn,
              )
                  ? 1
                  : 0.5,
              child: IgnorePointer(
                ignoring: context.select<CommandCenterNotifier, bool>(
                  (c) => !c.ballThrowerOn,
                ),
                child: Column(
                  children: [
                    SpeedSelector(
                      title: 'Feeder Speed:',
                      speed: context.select<CommandCenterNotifier, Speed>(
                        (c) => c.feederSpeed,
                      ),
                      speedChanged: (newSpeed) => context
                          .read<CommandCenterNotifier>()
                          .feederSpeed = newSpeed,
                    ),
                    SpeedSelector(
                      title: 'Shooter Speed:',
                      speed: context.select<CommandCenterNotifier, Speed>(
                        (c) => c.shooterSpeed,
                      ),
                      speedChanged: (newSpeed) => context
                          .read<CommandCenterNotifier>()
                          .shooterSpeed = newSpeed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column getLoaderUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        ),
        const SizedBox(height: 16),
        Text('Waiting for the robot to turn on...'),
      ],
    );
  }
}
