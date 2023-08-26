import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:todo_bloc/logic/bloc/todo_bloc.dart';

import 'package:todo_bloc/presentation/utils/size_constants.dart';
import 'package:todo_bloc/presentation/widgets/add_task_form.dart';
import 'package:todo_bloc/presentation/widgets/app_bar.dart';
import 'package:todo_bloc/presentation/widgets/to_do_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    // adding the initial todo fetch event initially.
    todoBloc.add(TodoInitialFetchEvent());
    super.initState();
  }

  // initialising the TodoBloc
  final TodoBloc todoBloc = TodoBloc();

  @override
  Widget build(BuildContext context) {
    // initialising tabcontroller for the tabs in home screen
    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              // date and add button
              topSection(context),
              SBC.xxLH,

              // tab section
              TabBar(
                controller: tabController,
                // isScrollable: true,
                // labelPadding: EdgeInsets.symmetric(
                //   horizontal: MediaQuery.of(context).size.width * 0.10,
                // ),
                dividerColor: Colors.transparent,
                // indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Text(
                      'Today',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 29, 29, 29),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'All',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color.fromARGB(255, 29, 29, 29),
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),

              // to do section
              BlocBuilder<TodoBloc, TodoState>(
                bloc: todoBloc,
                builder: (context, state) {
                  if (state is TodoFetchLoadingState) {
                    /*
                        retturning a circular progress indicator 
                        until the todos are fetched from the API 
                    */
                    return Container(
                      margin: const EdgeInsets.only(top: 210),
                      child: const CircularProgressIndicator(),
                    );
                  } else if (state is TodoFetchSuccesState) {
                    // displaying todo containers
                    final successState = state;
                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.94,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              // first tab for todos for today's date
                              SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: ListView.builder(
                                    itemCount: successState.todos.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        // SBC.sH,
                                        // defining condition where the todos for today's date are filtered
                                        if (successState.todos[index].date ==
                                            DateFormat.yMd()
                                                .format(DateTime.now()))
                                          // to do box
                                          ToDoContainer(
                                            bloc: todoBloc,
                                            docId: successState
                                                .todos[index].docId!,
                                            title: successState
                                                .todos[index].todoTitle,
                                            description: successState
                                                .todos[index].description,
                                            date:
                                                successState.todos[index].date,
                                            time:
                                                successState.todos[index].time,
                                            cat: successState
                                                .todos[index].category,
                                          ),
                                        SBC.sH,
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // second tab for all todos
                              SingleChildScrollView(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: ListView.builder(
                                    itemCount: successState.todos.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        SBC.xLH,
                                        // to do box
                                        ToDoContainer(
                                          bloc: todoBloc,
                                          docId:
                                              successState.todos[index].docId!,
                                          title: successState
                                              .todos[index].todoTitle,
                                          description: successState
                                              .todos[index].description,
                                          date: successState.todos[index].date,
                                          time: successState.todos[index].time,
                                          cat: successState
                                              .todos[index].category,
                                        ),
                                        SBC.sH,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is TodoFetchErrorState) {
                    /*
                        retturning a Normal text 
                        if the todos aren't fetched from the API
                    */
                    return Container(
                      margin: const EdgeInsets.only(top: 210),
                      child: Text(
                        'Add a todo.',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // top section containing date/ time details and add button
  Row topSection(BuildContext context) {
    // current date time.
    final now = DateTime.now();
    // formatting 'now' as day, date month.
    final formattedDate = DateFormat('EEEE, d MMMM').format(now);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // date/ time details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 24,
                    fontFamily: GoogleFonts.notoSans().fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SBC.sH,
            Text(
              formattedDate, // formatted date.
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 13,
                    fontFamily: GoogleFonts.notoSans().fontFamily,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
        // button to add new to do item
        ElevatedButton(
          // opening up the bottom modal sheet
          onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              context: context,
              builder: (context) => AddTaskForm() // new to do form,
              ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
          child: Text(
            '+ New Task',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 14,
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                  color: Theme.of(context).primaryColorDark,
                ),
          ),
        )
      ],
    );
  }
}
