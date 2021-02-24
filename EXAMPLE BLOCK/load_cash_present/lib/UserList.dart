import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit/UserCubit.dart';
import 'Models/User.dart';

class UserList extends StatelessWidget {
  List<User> _dataArray;

  @override
  Widget build(BuildContext context) {
    //говорит о том, что грузим юзеров при запуске
    final UserCubit userCubit = context.read();
    userCubit.fetchUser();

    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {

      if (state is UserEmptyState) {
        return Center(
          child: Text(
            'No data received.',
            style: TextStyle(fontSize: 20),
          ),
        );
      }

      if (state is UserLoadState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is UserLoadedState) {
        _dataArray = state.loadedUser;

        return ListView.builder(
            itemCount: _dataArray.length,
            itemBuilder: (context, index) {
              return _cellForIndex(index);
            });
      } else {
        ////state is UserErrorState
        return Center(
          child: Text('Error fetching users', style: TextStyle(fontSize: 20)),
        );
      }
    });
  }

  Widget _cellForIndex(int index) {
    //ячейка по индексу
    User obj = _dataArray[index];

    return Ink(
      color: Colors.grey[50], //выделение ячейки
      child: ListTile(
        
        subtitle: Text(obj.name),
        title: Text(obj.name),
        leading: CircleAvatar(
          child: Text(obj.id.toString()),
        ),
        trailing: Text(obj.email),
        onTap: () {
          print('---------${obj.name} - ${obj.phone}----------------');
        },
      ),
    );
  }

  // Widget _cellForIndex(int index) {
  //   //ячейка по индексу
  //   User obj = _dataArray[index];

  //   return Ink(
  //     color: Colors.grey[50], //выделение ячейки

  //     child: Container(
  //       color: index % 2 == 0 ? Colors.white : Colors.blue[50],
  //       child: ListTile(
  //         subtitle: Text(obj.name),
  //         title: Text(obj.name),
  //         leading: CircleAvatar(
  //           child: Text(obj.id.toString()),
  //         ),
  //         trailing: Text(obj.email),
  //         onTap: () {
  //           print('---------${obj.name} - ${obj.phone}----------------');
  //         },
  //       ),
  //     ),
  //   );
  // }




}





// color: index % 2 == 0 ? Colors.white : Colors.blue[50],
