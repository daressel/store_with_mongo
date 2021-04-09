import { Controller } from "stimulus"
import { ajaxRequest, fadeOut } from "../help_methods"

export default class extends Controller {
  connect() {
  }

  createProduct(){
    console.log('product')
  }

  addAttr(){
    console.log(123)
    return
    ajaxRequest({
      url: '/new_attr_product',
      method: 'post',
      data: { 'test': "test" },
      success: function(response){
        let element = document.getElementById('attributes');
        let tag = document.createElement('div');
        tag.innerHTML = response;
        element.appendChild(tag.firstChild);
      }
    })
  }

  deleteAttr(){
    event.target.closest('.attribute').remove();
  }
}
