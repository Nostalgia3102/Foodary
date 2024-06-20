
//TIMER

/*
late Timer _timer;

@override
void initState() {
  super.initState();
  _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
    if (_currentPage < 2) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  });
}

@override
void dispose() {
  _timer.cancel();
  _pageController.dispose();
  super.dispose();
}
*/