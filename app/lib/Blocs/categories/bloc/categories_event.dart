part of 'categories_bloc.dart';

abstract class CategoriesEvent {
  const CategoriesEvent();
}

class FetchCategories extends CategoriesEvent {}
