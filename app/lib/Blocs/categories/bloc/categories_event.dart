part of 'categories_bloc.dart';

abstract class CategoriesEvent {
  const CategoriesEvent();
}

class FetchCategories extends CategoriesEvent {}

class SelectCategory extends CategoriesEvent {
  final int? categoryId;
  SelectCategory({required this.categoryId});
}
