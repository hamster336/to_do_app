# to_do_app

A simple yet strucutred to-do application.

Features:
- Add, edit and remove tasks
- Mark the tasks as complete or incomplete
- Sort the tasks by date and priority
- Filter tasks by their state of completion (All/Active/Completion)
- Set due dates for tasks

This project uses BLoC for state management.
The app follows a clear separation of concerns:
- UI reacts to state changes
- Business logic is handled inside BLoCs
- Events drive all state transitions

All user actions (add, update, delete, select, complete) are dispatched as events and processed by the relevant BLoC.

Screenshots:
![image alt](https://github.com/hamster336/to_do_app/blob/f7ae3a86bdaeb1edca37ea3484644797f40be7f7/screenshots/dark.png)
![image alt](https://github.com/hamster336/to_do_app/blob/f7ae3a86bdaeb1edca37ea3484644797f40be7f7/screenshots/date_picker.png)
![image alt](https://github.com/hamster336/to_do_app/blob/f7ae3a86bdaeb1edca37ea3484644797f40be7f7/screenshots/delete.png)
![image alt](https://github.com/hamster336/to_do_app/blob/f7ae3a86bdaeb1edca37ea3484644797f40be7f7/screenshots/editing_task.png)
![image alt](https://github.com/hamster336/to_do_app/blob/f7ae3a86bdaeb1edca37ea3484644797f40be7f7/screenshots/home_screen.png)
