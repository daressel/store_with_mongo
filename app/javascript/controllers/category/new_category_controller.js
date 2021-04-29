import { Controller } from "stimulus"
import { ajaxRequest, fadeOut, emptyForms, fillCategoryName } from "../help_methods"

export default class extends Controller {
  connect() {
  }

  createCategory(){
    if(emptyForms()){
      return
    }
    else{
      let attributes = document.getElementById('attributes');
      const rows = attributes.getElementsByClassName('attribute');
      let params = {
        parent: document.getElementById('parent-text').value,
        name: document.getElementById('name').value
      }      
      attributes = {}
      Array.from(rows).forEach(function(form){
        attributes[form.querySelector('#attr-name').value] = form.querySelector('#unit').selectedOptions[0].label
      })
      params.attributes = attributes
      ajaxRequest({
        url: '/categories',
        method: 'post',
        data: params,
        success: function(response){
          console.log('success');
          window.location.pathname = '/products'
        }
      })
    }
  }

  clickCategory(){
    fillCategoryName('parent-text')
  }

  addAttr(){
    ajaxRequest({
      url: '/new_attr_category',      
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