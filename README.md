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
<p align="left">
  <img src="screenshots/home_screen.png" width="200">
  <img src="screenshots/light_ui.png" width="200">
  <img src="screenshots/dark.png" width="200">
</p>

<p align="left">
  <img src="screenshots/date_picker.png" width="200">
  <img src="screenshots/editing.png" width="200">
</p>

<p align="left">
  <img src="screenshots/priority.png" width="200">
  <img src="screenshots/sorting.png" width="200">
</p>
