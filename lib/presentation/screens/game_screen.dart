// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';
// import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
// import 'package:moving_box/presentation/bloc/game_bloc/game_state.dart';
// import 'package:moving_box/presentation/components/mission_card.dart';

// class GameScreen extends StatelessWidget {
//   const GameScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocConsumer<GameBloc, GameState>(
//         builder: (context, state) {
//           return AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             transitionBuilder: (child, animation) {
//               return ScaleTransition(
//                 scale: animation,
//                 child: FadeTransition(opacity: animation, child: child),
//               );
//             },
//             child: () {
//               // parcel moving
//               if (state is ParcelMoving) {
//                 return Container(
//                   key: const ValueKey('moving'),
//                   width: double.infinity,
//                   height: double.infinity,
//                   color: state.backgroundColor,
//                 );
//               }

//               // parcel stopped
//               if (state is ParcelStopped) {
//                 return Center(
//                   key: ValueKey('stopped '),
//                   child: MissionCard(
//                     mission: state.mission,
//                     onPass: () => context.read<GameBloc>().add(ParcelPassed()),
//                   ),
//                 );
//               }

//               // default
//               return Container(key: const ValueKey('default'));
//             }(),
//           );
//         },
//         listener: (context, state) {
//           print(state);
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_bloc.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_event.dart';
import 'package:moving_box/presentation/bloc/game_bloc/game_state.dart';
import 'package:moving_box/presentation/components/mission_card.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          print(state);
        },
        builder: (context, state) {
          Widget child;

          // parcel moving
          if (state is ParcelMoving) {
            child =
                Container(
                  key: const ValueKey('moving'),
                  width: double.infinity,
                  height: double.infinity,
                  color: state.backgroundColor,
                ).animate(key: const ValueKey('moving')).fadeIn().scaleXY();
          }
          // parcel stopped
          else if (state is ParcelStopped) {
            child = Center(
              key: const ValueKey('stopped'),
              child:
                  MissionCard(
                        mission: state.mission,
                        onPass:
                            () => context.read<GameBloc>().add(ParcelPassed()),
                      )
                      .animate(key: ValueKey(state.mission))
                      .fadeIn(duration: 300.ms)
                      .scale(),
            );
          }
          // default
          else {
            child = Container(key: const ValueKey('default'));
          }

          return AnimatedSwitcher(duration: 300.ms, child: child);
        },
      ),
    );
  }
}
