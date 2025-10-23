enum PopScopeOrder {
  first(0),
  second(1),
  third(2), // you can add more orders here if you need to
  last(100);

  const PopScopeOrder(this.value);
  final int value;
}
