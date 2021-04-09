export function ajaxRequest(params){
  const csrfToken = document.querySelector("[name='csrf-token']").content
  let options = {};
  if (params.method.toUpperCase() === 'GET' && params.hasOwnProperty('data')){
    params.url += '?'
    for(const [key, value] of Object.entries(params.data)){
      params.url += `${key}=${value}&`
    }
    options = {
      method: params.method.toUpperCase(),
    }
  }
  else{
    options = {
      method: params.method,
      body: JSON.stringify(params.data),
      headers: {
        'Content-Type': 'application/json',
        "X-CSRF-Token": csrfToken
      },   
    }
  }
  fetch(params.url, options)
    .then(data => data.text())
    .then(params.success)
    .catch(params.failed)
}

export function fadeOut(el) {
  el.style.opacity = 1;
  (function fade() {
    if ((el.style.opacity -= .1) < 0) {
      el.style.display = "none";
    } else {
      requestAnimationFrame(fade);
    }
  })();
};

export function emptyForms(){
  let arr = Array.from(document.getElementsByClassName('form-control'))  
  arr.forEach(element => {
    if(element.value == ''){ element.classList.add('need-to-fill') }
    else{ element.classList.remove('need-to-fill') }      
  })
  if(arr.some(isErr) || arr.some(isTrue)) {  
    alert('Заполните необходимые поля');   
    return true
  }
  else { return false}
}

function isTrue(element) {
  if(element.value == ''){
    return true
  }
  else{ return false }
}

function isErr(element) {
  if(element.style.borderColor == 'red'){
    return true
  }
  else{ return false }
}
export function changeForm(){
  console.log(123)
  event.target.classList.remove('need-to-fill')
}
