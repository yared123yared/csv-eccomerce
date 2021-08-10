part of 'categories_bloc.dart';

abstract class CategoriesState {
  final List<Categories> categories;

  CategoriesState({required this.categories});
}

class CategoriesInitial extends CategoriesState {
  CategoriesInitial() : super(categories: []);
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading() : super(categories: []);
}

class CategoriesLoadSuccess extends CategoriesState {
  final List<Categories> categories;
  CategoriesLoadSuccess({required this.categories})
      : super(categories: categories);
}

class CategoriesLoadFailed extends CategoriesState {
  final String message;
  CategoriesLoadFailed({required this.message}) : super(categories: []);
}
