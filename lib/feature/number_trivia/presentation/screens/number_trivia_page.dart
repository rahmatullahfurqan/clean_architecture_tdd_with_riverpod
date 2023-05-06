import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tdd_with_riverpod/core/config/theme.dart';
import 'package:flutter_tdd_with_riverpod/core/error/messages.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/provider/get_random_number_trivia_provider.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/provider/number_trivia_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../domain/usecases/get_concreate_number_trivia.dart';
import '../../provider/get_concreate_number_trivia_provider.dart';
import '../widgets/default_search_box.dart';

class NumberTrivaPage extends HookConsumerWidget {
  const NumberTrivaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(getInitialNumberTriviaProvider(
        GetRandomNumberTriviaParams(context: context)));
    final numberTrivia = ref.watch(currentNumberTriviaProvider);
    final getConcreateSearch = useState("");
    final textEditingController = useTextEditingController();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 50,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        centerTitle: false,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        automaticallyImplyLeading: true,
        title: Text(
          "Number Trivia",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  numberTrivia.loading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 150.0),
                          child: SizedBox(
                            height: 10,
                            child: OverflowBox(
                              maxHeight: 200,
                              minHeight: 100,
                              child: Lottie.asset(
                                'assets/animations/simple_loader.json',
                                animate: true,
                                repeat: true,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            numberTrivia.trivia.number.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                  Text(
                    numberTrivia.loading ? "" : numberTrivia.trivia.text,
                    style: Theme.of(context).textTheme.subHead2,
                    textAlign: TextAlign.center,
                  ),
                  DefaultSearchBoxWidget(
                    hint: "Tulis Angka",
                    textEditingController: textEditingController,
                    textInputType: TextInputType.number,
                    action: (value) {
                      getConcreateSearch.value = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        if (int.tryParse(textEditingController.text) == null) {
                          return ErrorMessageNotification.localHandler(
                              context, "Hanya Dapat Memasukkan Angka");
                        }
                        ref
                            .read(currentNumberTriviaProvider.notifier)
                            .setNumberTrivia(
                                const NumberTriviaState(loading: true));
                        ref.read(getConcreateNumberTriviaProvider(
                            GetConcreateNumberTriviaParams(
                                context: context,
                                number:
                                    int.parse(textEditingController.text))));
                        textEditingController.text = "";
                      },
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                              fixedSize: MaterialStateProperty.all<Size?>(
                                Size(MediaQuery.of(context).size.width, 32),
                              ),
                              textStyle: MaterialStateProperty.all<TextStyle?>(
                                  Theme.of(context).textTheme.paragraph3)),
                      child: Text("Search".toTitleCase()),
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              textEditingController.text = "";
                              ref
                                  .read(currentNumberTriviaProvider.notifier)
                                  .setNumberTrivia(
                                      const NumberTriviaState(loading: true));
                              ref.read(getRandomNumberTriviaProvider(
                                  GetRandomNumberTriviaParams(
                                      context: context)));
                            },
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                    fixedSize: MaterialStateProperty.all<Size?>(
                                      Size(MediaQuery.of(context).size.width,
                                          32),
                                    ),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle?>(
                                            Theme.of(context)
                                                .textTheme
                                                .paragraph3)),
                            child: Text("Get Random Trivia".toTitleCase()))),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/onboarding_three.png',
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
