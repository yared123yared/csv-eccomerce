import 'dart:async';

import 'package:app/models/category/categories.dart';
import 'package:app/repository/categories_repository.dart';
import 'package:bloc/bloc.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryRepository categoryRepository;
  CategoriesBloc({required this.categoryRepository})
      : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is FetchCategories) {
      yield CategoriesLoading();
      try {
        List<Categories> categories =
            (await this.categoryRepository.getCategories()) as List<Categories>;
        if (categories == []) {
          print("Failed to fech categories");
          yield CategoriesLoadFailed(message: "Failed to Fetch");
        } else {
          yield CategoriesLoadSuccess(
              categories: categories, selectedCategoryId: null);
        }
      } catch (e) {
        print(e.toString());
      }
    } else if (event is SelectCategory) {
      yield CategoriesLoadSuccess(
          categories: state.categories, selectedCategoryId: event.categoryId);
    }
  }
}
