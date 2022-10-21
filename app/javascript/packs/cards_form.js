$(document).on("change", "#question_file", function () {
  console.log(this.files[0]);
  var imgCodified = URL.createObjectURL(this.files[0]);
  $(".question_file").attr("src", imgCodified).height(200);
});

$(document).on("change", "#answer_file", function () {
  console.log(this.files[0]);
  var imgCodified = URL.createObjectURL(this.files[0]);
  $(".answer_file").attr("src", imgCodified).height(200);
});
