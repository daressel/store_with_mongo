$(document).on('turbolinks:load', function() {  
  $("#input-pictures").change(function(e) {
    $("#preview").empty();
    var storedFiles = [];
    var files = e.target.files;
    var filesArr = Array.prototype.slice.call(files);
    filesArr.forEach(function(f) {
      if (!f.type.match("image.*")) {
        return;
      }
      storedFiles.push(f);
      var reader = new FileReader();
      reader.onload = function(e) {
        var html = `<div style='display: inline-block;'><img src=${e.target.result} data-file=${f.name} ' class='selFile' title='Click to remove' style='height: 150px'></div>`;
        $("#preview").append(html);
      }
      reader.readAsDataURL(f);
    })
  })
  $('#showSideMenu').on('click', function() {
    $('body').addClass('inaction');
    $('body').css({'overflow':'hidden'});
    $('.sideMenu').addClass('show');
  })

  $('.closeSideMenu').on('click', function() {
    $('.sideMenu').removeClass('show');
    $('body').removeClass('inaction');
    $('body').css({'overflow':'auto'});
  })

  $('.cart_btn').on('click', function(e){
    let product = $(this).closest('.field').data('product');
    let target = e.target;
    let url = '';
    let text = '';
    if ($(target).text() == 'Добавить в корзину'){
      text = "Убрать из корзины";
      url = '/add_to_cart';
    }
    else{
      text = "Добавить в корзину";
      url = '/remove_from_cart';
    }
    $.ajax({
      url: url,
      method: 'POST',
      data: { id: product },
      success: function(response){
        $(target).text(text);
        if (response.quantity > 0){
          $("#quantity-product").text(response.quantity);
          $("#quantity-product").removeClass('d-none');
        }
        else{
          $("#quantity-product").addClass('d-none');
        }
      }
    })
  })
})
