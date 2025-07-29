
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gifthunt/src/features/onboarding/application/gift_profile_notifier.dart';
import 'package:gifthunt/src/features/onboarding/presentation/widgets/multi_choice_question_widget.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> interestsOptions = [
    'Technologie', 'Mode', 'Sport', 'Cuisine', 'Lecture', 'Voyage', 'Musique', 'Art', 'Jeux vidéo', 'Nature'
  ];
  final List<String> occasionsOptions = [
    'Anniversaire', 'Noël', 'Mariage', 'Fête des Mères', 'Fête des Pères', 'Saint-Valentin', 'Diplôme', 'Crémaillère', 'Départ à la retraite', 'Juste pour le plaisir'
  ];
  final List<String> giftTypesOptions = [
    'Expérience', 'Objet physique', 'Carte cadeau', 'Service', 'Donation'
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final giftProfile = ref.watch(giftProfileNotifierProvider);
    final giftProfileNotifier = ref.read(giftProfileNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[
          MultiChoiceQuestionWidget(
            question: "Quels sont les centres d'intérêt de la personne ?",
            options: interestsOptions,
            initialSelection: giftProfile.interests,
            onSelectionChanged: (selected) {
              giftProfileNotifier.updateInterests(selected);
            },
          ),
          MultiChoiceQuestionWidget(
            question: "Pour quelle occasion est ce cadeau ?",
            options: occasionsOptions,
            initialSelection: giftProfile.occasions,
            onSelectionChanged: (selected) {
              giftProfileNotifier.updateOccasions(selected);
            },
          ),
          MultiChoiceQuestionWidget(
            question: "Quel type de cadeau recherchez-vous ?",
            options: giftTypesOptions,
            initialSelection: giftProfile.giftTypes,
            onSelectionChanged: (selected) {
              giftProfileNotifier.updateGiftTypes(selected);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quel est votre budget ?',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Slider(
                  value: giftProfile.budget,
                  min: 0,
                  max: 1000,
                  divisions: 100,
                  label: giftProfile.budget.round().toString(),
                  onChanged: (value) {
                    giftProfileNotifier.updateBudget(value);
                  },
                ),
                Text('Budget: ${giftProfile.budget.round()} €'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _currentPage == 3
          ? FloatingActionButton.extended(
              onPressed: () {
                // TODO: Save GiftProfile data (e.g., to Firebase or local storage)
                // For now, just navigate
                context.go('/game');
              },
              label: const Text('Lancer la chasse'),
              icon: const Icon(Icons.arrow_forward),
            )
          : FloatingActionButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              child: const Icon(Icons.arrow_forward),
            ),
    );
  }
}
