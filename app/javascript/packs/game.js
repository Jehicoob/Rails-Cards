var deck_code = $(".game-content").data("deck");

var cards;
var current_card = 1;

var deck_score_succesfull_cards = 0;
var deck_score_total_score = 0;

console.log(deck_code);

(function (window, undefined) {
  cards = getCards();
  changeText(cards, current_card);
})(window);

$(".view-game").on("click", ".flip-card", showBack);

$(".view-game").on("click", ".points", function () {
  $(".points").prop("disabled", true);
  let points = this.value;
  calcDeckScoreParams(points);
  updateCardScore(points, cards, current_card, deck_code);
  $(".next-card").show();
});

$(".view-game").on("click", ".next-card", function () {
  $(".points").prop("disabled", false);
  if (current_card < cards.length) {
    current_card += 1;
    changeText(cards, current_card);
    reset();
  } else {
    updateDeckScore(deck_code, deck_score_succesfull_cards);
    openResultModal(deck_code);
    $(".deck-score").text(`Score: ${deck_score_total_score}`);
    $(".succesfull_cards").text(
      `${deck_score_succesfull_cards} out of ${cards.length}`
    );
  }
});

$(".view-game").on("click", ".qualification", function (e) {
  $(".qualification").hide();
  updateDeckScoreQualification(this.value, deck_code);
});

// functions

function showBack() {
  $("#flip-card-button").hide();
  $("#set-score").show();
  $("#game-front").css("transform", "rotateY(180deg)");
  $("#game-back").css("transform", "rotateY(360deg)");
}

function reset() {
  $("#flip-card-button").show();
  $("#set-score").hide();
  $(".next-card").hide();
  $("#game-front").css("transform", "rotateY(0deg)");
  $("#game-back").css("transform", "rotateY(180deg)");
}

function changeText(cards, current_card) {
  var question = $("#game-question");
  var answer = $("#game-answer");
  var card_number = $(".game-cards");

  question.text(`${cards[current_card - 1].question}`);
  answer.text(`${cards[current_card - 1].description}`);
  card_number.text(`${current_card} / ${cards.length}`);
}

function getCards() {
  var result;
  $.ajax({
    url: "/get_cards",
    type: "get",
    async: false,
    data: { deck_code: deck_code },
  })
    .done(function (data) {
      result = data;
    })
    .fail(function (data) {
      console.log(`Failed to get cards, error: ${data}`);
    });
  return result;
}

function getScore(card_id, deck_code) {
  var result;
  $.ajax({
    url: "/get_score",
    type: "get",
    async: false,
    data: { card_id: card_id, deck_code: deck_code },
  })
    .done(function (data) {
      result = data;
    })
    .fail(function (data) {
      console.log("Failed to get cards");
    });
  return result;
}

function updateCardScore(points, cards, current_card, deck_code) {
  var score = getScore(cards[current_card - 1].id, deck_code);

  var plays = score.plays + 1;
  var total_score = calcSuma(points, score.total_score);
  var average = calcAverage(total_score, plays);

  $.ajax({
    url: `/card_scores/${score.id}`,
    type: "patch",
    data: {
      score_id: score.id,
      card_score: {
        total_score: total_score,
        plays: plays,
        average: average,
      },
    },
  }).done(function (data) {
    console.log("Saved!");
  });
}

function calcSuma(points, total_score) {
  var res;
  res = points + total_score;
  return res;
}

function calcAverage(total_score, plays) {
  var res;
  res = total_score / plays;
  return res;
}

// Open result

function openResultModal(deck_code) {
  $.ajax({
    url: "/result",
    type: "get",
    async: false,
    data: { deck_code: deck_code },
  });
}

// Deck Score

function calcDeckScoreParams(points) {
  deck_score_total_score += points;
  if (points >= 3) {
    deck_score_succesfull_cards += 1;
  }
}

function updateDeckScoreQualification(qualification, deck_code) {
  var deck_score = getDeckScore(deck_code);
  $.ajax({
    url: `/deck_scores/${deck_score.id}`,
    type: "patch",
    async: false,
    data: {
      deck_score_id: deck_score.id,
      deck_score: {
        qualification: qualification,
      },
    },
  }).fail(function (data) {
    console.log(`Error: ${data}`);
  });
}

function updateDeckScore(deck_code, deck_score_succesfull_cards) {
  var total_deck_score = getTotalScore(deck_code);
  var deck_score = getDeckScore(deck_code);

  $.ajax({
    url: `/deck_scores/${deck_score.id}`,
    type: "patch",
    async: false,
    data: {
      deck_score_id: deck_score.id,
      deck_score: {
        score: total_deck_score,
        successful_cards: deck_score_succesfull_cards,
      },
    },
  }).fail(function (data) {
    console.log(`Error: ${data}`);
  });
}

function getDeckScore(deck_code) {
  var result;
  $.ajax({
    url: "/get_deck_score",
    type: "get",
    async: false,
    data: { deck_code: deck_code },
  })
    .done(function (data) {
      result = data;
    })
    .fail(function (data) {
      console.log(`Error: ${data}`);
    });
  return result;
}

function getTotalScore(deck_code) {
  var result;
  $.ajax({
    url: "/get_total_score",
    type: "get",
    async: false,
    data: { deck_code: deck_code },
  })
    .done(function (data) {
      result = data;
    })
    .fail(function (data) {
      console.log(`Error: ${data}`);
    });
  return result;
}
