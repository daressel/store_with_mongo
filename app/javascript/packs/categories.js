$(document).on('turbolinks:load', function() {
  $('.category_search').hover(
    showCat,
    function(){}
  )
  $('.category_new').hover(
    showCat,
    function(){}
  )

  function showCat(){
    let square = document.getElementById(this.dataset.category);
    const maxLevel = $(this).closest('.category-block').data('lvl');
    const curLevel = $(this).closest('.category-list').data('lvl');
    for(let nextLevel = curLevel + 1; nextLevel <= maxLevel; nextLevel += 1){
      Array.from(document.getElementsByClassName('lvl-' + nextLevel)).forEach(el => {
        $(el).removeClass('active');
      });
    }
    $(square).addClass('active');
    let left = $(this).offset().left + $(this).outerWidth() + 3;
    let top = $(this).offset().top;
    $(square).css({top: top, left: left});
  }

  $('.category_new').click(function(){
    $('#parent-val').val($(this).text());
    $('#parent-text').val($(this).text());
    const maxLevel = $(this).closest('.category-block').data('lvl');
    for(let nextLevel = 1; nextLevel <= maxLevel; nextLevel += 1){
      Array.from(document.getElementsByClassName('lvl-' + nextLevel)).forEach(el => {
        $(el).removeClass('active');
      });
    }
  })
})

