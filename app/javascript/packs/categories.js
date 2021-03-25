$(document).on('turbolinks:load', function() {
  $(".category").hover(
    showCat,
    function(){}
  )

  function showCat(){
    let square = document.getElementById(this.dataset.category);
    Array.from(document.getElementsByClassName('active')).forEach(el => {
      $(el).removeClass('active')
    });
    $(square).addClass('active');
    let left = $(this).offset().left + $(this).outerWidth() + 3;
    let top = $(this).offset().top;
    $(square).css({top: top, left: left});
  }
})