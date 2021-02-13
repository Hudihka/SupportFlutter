
import 'package:flutter_bloc/flutter_bloc.dart';

/*

//события по нажатию на кнопки
abstract class UserEvent {}

class UserLoadEvent extends UserEvent {}

class UserClearEvent extends UserEvent {}


//что делаем в результате
abstract class UserState {}

//список пустой
class UserEmptyState extends UserState {}

//список загрузки
class UserLoadState extends UserState {}

//список узеры загружены
class UserLoadedState extends UserState {
  List<dynamic> loadedUser;
  //@required обязателен для передачи
  // assert это обяз условие без которого не начнетсы выполнение
  UserLoadedState({@required this.loadedUser, List<User> loadedYser}) : assert(loadedUser != null);
}

//когда произошла ошибка при загрузке
class UserErrorState extends UserState {}

*/

enum Events{
  pressAdd,
  pressMinus
}

enum StateEnum{
  stateAdd,
  stateMinus,
  stateNone
}

class UserBlock extends Bloc<Events, StateEnum> {
  UserBlock(StateEnum initialState) : super(initialState);


  @override
  Stream<StateEnum> mapEventToState(Events event) async* {//async* работа с потоком

    if (event == Events.pressAdd){
      yield StateEnum.stateAdd;
    } else if (event == Events.pressMinus){
      yield StateEnum.stateMinus;
    } else {
      yield StateEnum.stateNone;
    }

  }
}