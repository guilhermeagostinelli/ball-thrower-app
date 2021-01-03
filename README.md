# ball-thrower-app
A Flutter app for controlling a table tennis ball thrower robot.

## About the robot
The robot consists of two motors: a feeder and a shooter.

The shooter is a DC motor responsible for throwing the ball. The speed of the shooter determines the amount of spin generated in the ball.

The feeder consists of a stepper motor to which the feeder plate is attached. Its speed dictates how fast the ball reaches the shooter, thus determining the interval between each throw.

The app controls the robot by sending HTTP requests to a RESTful API (https://github.com/guilhermeagostinelli/ball-thrower-server) which acts as an interface to communicate with each motor.

![App screenshot](./screenshots/app.png?raw=true)

## Note
Before running the app, change the server URL and port in the [Config class](/lib/Config/Config.dart).

## Contributing

Feel free to contribute with corrections, optimizations, etc. There are no strict guidelines on how one should contribute.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.