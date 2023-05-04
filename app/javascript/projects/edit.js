$(document).ready(function(){
  const editBtn = document.getElementById('editBtn');
  const editables = document.querySelectorAll('#name, #description, #status')

  editBtn.addEventListener('click', function(e) {
    if (!editables[0].isContentEditable) {
      editables[0].contentEditable = 'true';
      editables[1].contentEditable = 'true';
      editables[2].contentEditable = 'true';
      document.getElementById('pencil-icon').style.display = 'none';
      document.getElementById('save-button').style.display = 'block';
    } else {

    editables[0].contentEditable = 'false';
      editables[1].contentEditable = 'false';
      editables[2].contentEditable = 'false';

      document.getElementById('save-button').style.display = 'none';
      document.getElementById('pencil-icon').style.display = 'block';

      for (var i = 0; i < editables.length; i++) {
        localStorage.setItem(editables[i].getAttribute('id'), editables[i].innerHTML);
      }
    }
  });

  $('#save-button').on('click', function(){
    $('#project_name').val($('#name').html());
    $('#project_description').val($('#description').html().replaceAll("\n", "")).replaceAll("\r", "");
    $('#project_next_status').val($('#status').html());
    $('#update-project-button').click();
  })
});