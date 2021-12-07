import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week5kobo360/bloc/counter_cubit.dart';
import 'package:week5kobo360/user_interface/pokemon_screen.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CounterCubit, int>(builder: (context, state) {
              return Text(
                '$state',
                style: TextStyle(fontSize: 30),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increase();
                  },
                  child: Text('Increase'),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrease();
                  },
                  child: Text('Decrease'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PokemonScreen(),
                      ),
                    );
                  },
                  child: Text('Move To Pokemon Page'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
