part of 'categories_bloc.dart';

abstract class CategoriesState {
  final List<Categories> categories;
  final int? selectedCategoryId;
  CategoriesState({required this.categories, required this.selectedCategoryId});
}

class CategoriesInitial extends CategoriesState {
  CategoriesInitial() : super(categories: [], selectedCategoryId: null);
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading() : super(categories: [], selectedCategoryId: null);
}

class CategoriesLoadSuccess extends CategoriesState {
  final List<Categories> categories;
  final int? selectedCategoryId;
  CategoriesLoadSuccess(
      {required this.categories, required this.selectedCategoryId})
      : super(categories: categories, selectedCategoryId: null);
}

class CategoriesLoadFailed extends CategoriesState {
  final String message;
  CategoriesLoadFailed({required this.message})
      : super(categories: [], selectedCategoryId: null);
}
