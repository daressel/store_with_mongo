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
})