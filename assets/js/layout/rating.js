document.addEventListener('DOMContentLoaded', function () {

  var rootEl = document.documentElement;
  var $ratings = document.querySelectorAll('.rating');

  if ($ratings.length > 0) {
    $('.rating').barrating('show', {
      theme: 'bars-reversed',
      showSelectedRating: true,
      reverse: false
    });
  }

});
