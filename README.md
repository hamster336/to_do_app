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

Home Screen UI:
<p align="left">
  <img src="screenshots/home_screen.png" width="200">
  <img src="screenshots/light_ui.png" width="200">
</p>

Task editing:
<p align="left">
  <img src="screenshots/date_picker.png" width="200">
  <img src="screenshots/editing.png" width="200">
</p>

Setting priority:
<p align="left">
  <img src="screenshots/priority1.png" width="200">
  <img src="screenshots/priority2.png" width="200">
  <img src="screenshots/priority3.png" width="200">
</p>

Sort Highlighting and FromTo sort:
<p align="left">
  <img src="screenshots/sortHighlight.png" width="200">
  <img src="screenshots/fromTo.png" width="200">
</p>
