document.addEventListener('DOMContentLoaded', function () {

  // Get all "message" elements
  var $messages = Array.prototype.slice.call(document.querySelectorAll('.message .delete'), 0);

  // Check if there are any messages
  if ($messages.length > 0) {

    // Add a click event on each of them
    $messages.forEach(function ($el) {
      $el.addEventListener('click', function () {

        // Get the target
        var $target = $el.closest('.message');

        // Toggle the class
        $target.classList.toggle('is-hidden');
      });
    });
  }

});
