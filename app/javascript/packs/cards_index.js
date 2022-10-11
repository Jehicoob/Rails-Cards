// Habilita el boton "Upload" al subir un archivo

$("#attach_file").on("change", function () {
  $(".upload_file").prop("disabled", this.files.length == 0);
});
