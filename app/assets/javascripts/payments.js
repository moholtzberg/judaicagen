$(function() {
    var elements = stripe.elements();

    var card = elements.create('card');

    card.mount('#card-element');

    card.addEventListener('change', function(event) {
      var displayError = $('#card-errors');
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {
        displayError.textContent = '';
      }
    });

    $('#payment-form .submit_btn').on('click', function(event) {
      event.preventDefault();

      stripe.createToken(card).then(function(result) {
        if (result.error) {
          var errorElement = $('#card-errors');
          errorElement.textContent = result.error.message;
        } else {
          stripeTokenHandler(result.token);
        }
      });
    });

    function stripeTokenHandler(token) {
      $('#payment-form').append($('<input type="hidden" name="card_token" value="'+token.id+'">'));
      $('#payment-form').append($('<input type="hidden" name="item_id" value="'+item_id+'">'));
      $('#payment-form').submit();
    }
});