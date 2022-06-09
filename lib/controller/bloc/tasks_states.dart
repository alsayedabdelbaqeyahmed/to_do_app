abstract class TasksStates {}

class TasksInitialStates extends TasksStates {}

class TasksAddStates extends TasksStates {}

class TasksGetStates extends TasksStates {}

class TasksEditStates extends TasksStates {}

class TasksDeleteStates extends TasksStates {}

class TasksBottomBarStates extends TasksAddStates {}
