mixin Refreshable {
  void refresh();
}

mixin FullRefreshable {
  void fullRefresh();
}

mixin FocusableTab {
  void focusActiveTabIfReady();
}

mixin SearchInputFocusable {
  void focusSearchInput();
}

mixin LibraryLoadable {
  void loadLibraryByKey(String libraryGlobalKey);
}
