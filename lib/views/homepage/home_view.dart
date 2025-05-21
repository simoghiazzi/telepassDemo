import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/components/reels/reel.dart';
import '../../repositories/reels_repository.dart';
import '../../viewmodels/reels_view_model.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    'Le novità del mondo Telepass',
                    style: appTextStyles.headingL,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rimani aggiornato su tutte le nostre attività',
                    style: appTextStyles.headingS.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            BlocProvider(
              create: (_) => ReelsCubit(ReelsRepository())..loadReels(),
              child: BlocBuilder<ReelsCubit, ReelsState>(
                builder: (context, state) {
                  if (state is ReelsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ReelsLoaded) {
                    return SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.reels.length,
                        separatorBuilder:
                            (context, i) => const SizedBox(width: 24),
                        itemBuilder: (context, i) => Reel(reel: state.reels[i]),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Errore nel caricamento dei reels'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
