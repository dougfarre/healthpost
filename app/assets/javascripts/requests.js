$(document).ready(function () {
  try {
    state_histories = JSON.parse($('#histories').val())
    $(state_histories).each(function () {
      $('#' + this.state).addClass("back_green");
    });
  } catch(error) {
    console.log(error);
  }
});

