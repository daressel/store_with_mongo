$(document).on('turbolinks:load', function() {
  attr_func();

  $(".create-provider").click(function(){
    let namesArr = [];
    let valuesArr = [];
    let url  = this.dataset.model;
    let forms = document.getElementById('new-provider').getElementsByClassName('form-control');
    let validate = document.getElementsByClassName('validate');
    let namesBlocks = document.getElementsByClassName('attr-name');
    let valuesBlocks = document.getElementsByClassName('attr-value');
    let provider = document.getElementsByTagName('select')[0];
    provider = provider.options[provider.selectedIndex].text;
    Array.from(forms).forEach( (el) => {
      el.classList.remove('validate');
    });

    Array.from(forms).forEach( (el) => {
      if(el.value == ''){
        el.classList.add('validate');
      }
    });

    Array.from(namesBlocks).forEach( (el) => {
      namesArr.push(el.value);
    });

    Array.from(valuesBlocks).forEach( (el) => {
      valuesArr.push(el.value);
    });

    if(validate.length > 0){
      alert("Обязательно заполните красные поля")
    }
    else {
      let params = {
        name: document.getElementById('name').value,
        namesAttr: namesArr,
        valuesAttr: valuesArr,
        provider: provider
      }
      $.ajax({
        url: url,
        method: 'POST',
        data: params,
        success: function(){
          console.log(12312312)
        }
      })
    }
  })

  function attr_func(){
    $(".delete-attr").click(function(){
      let attr = $(this).closest(".attribute")
      attr.fadeOut(function(){
        attr.remove()
      })
    })
  }
});
