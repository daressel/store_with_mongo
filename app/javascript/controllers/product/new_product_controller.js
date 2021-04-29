import { Controller } from "stimulus"
import { ajaxRequest, fadeOut, emptyForms, fillCategoryName } from "../help_methods"

export default class extends Controller {
  connect() {
  }

  createProduct(){
    if(emptyForms()){
      return
    }
    else{
      let preview = document.getElementById('preview');
      let images_form = preview.getElementsByTagName('img');
      let attributes = {};
      let images = {};
      let attributesCategory = document.getElementById('attributes-category');
      let attributesProduct = document.getElementById('attributes');
      const rowsCategory = attributesCategory.getElementsByClassName('attribute');
      const rowsProduct = attributesProduct.getElementsByClassName('attribute');
      let params = {
        category: document.getElementById('category-name').value,
        provider: document.getElementById('provider').selectedOptions[0].label,
        name: document.getElementById('name').value
      }
      Array.from(images_form).forEach(function(image){
        images[image.dataset.file] = image.src
      })
      params.images = images;
      Array.from(rowsCategory).forEach(function(form){
        attributes[form.querySelector('#attr-name').value] = [form.querySelector('#attr-value').value, form.querySelector('#unit').value]
      })
      Array.from(rowsProduct).forEach(function(form){
        attributes[form.querySelector('#attr-name').value] = [form.querySelector('#attr-value').value, form.querySelector('#unit').selectedOptions[0].label]
      })
      params.attrs = attributes;
      console.log(params);
      ajaxRequest({
        url: '/products',
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
    fillCategoryName('category-name')
    ajaxRequest({
      url: '/attrs_list',
      data: {
        name: document.getElementById('category-name').value,
      },
      success: function(response){
        $('#attributes-category').html(response);
      }
    })
}

  addAttr(){
    ajaxRequest({
      url: '/new_attr_product',
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
