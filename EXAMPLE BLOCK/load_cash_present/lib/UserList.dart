

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit/UserCubit.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //говорит о том, что грузим юзеров при запуске
    final UserCubit userCubit = context.read();
    userCubit.fetchUser();

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        
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
        return ListView.builder(
          itemCount: state.loadedUser.length,
          itemBuilder: (context, index) => Container(
            color: index % 2 == 0 ? Colors.white : Colors.blue[50],
            child: ListTile(
              leading: Text(
                'ID: ${state.loadedUser[index].id}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Column(
                children: [
                  Text(
                    '${state.loadedUser[index].name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Text(
                        'Email: ${state.loadedUser[index].email}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        'Phone: ${state.loadedUser[index].phone}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      } else {////state is UserErrorState
        return Center(
          child: Text(
            'Error fetching users', 
            style: TextStyle(fontSize: 20)
            ),
        );
      }

    });
  }
}

