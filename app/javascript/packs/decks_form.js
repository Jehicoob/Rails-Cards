console.log("Decks form");

console.log($(".colors"));

$("#deck_font_color").selec;

$(".colors").each(function () {
  console.log(this.value);
  $(this).css("background", `${this.value}`);
});
