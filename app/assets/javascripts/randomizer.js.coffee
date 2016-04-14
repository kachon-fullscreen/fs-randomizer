# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

console.log ("hello")
all_words = []
answer_words = []
$.get '/randomizer_words', (data) ->
  all_words = data[0]
  answer_words = data[1]
  console.log all_words
  console.log answer_words

Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1

get_random_word_from_all_word = ->
  # words = $('#all_words').val().split("\n")
  words = all_words
  index = Math.floor(Math.random() * words.length)
  word = words[index]
  return word

get_random_word_from_word = ->
  #words = $('#words').val().split("\n")
  words = answer_words
  index = Math.floor(Math.random() * words.length)
  word = words[index]
  return word

counter = 0
callback = ->
  console.log ("display")
  if counter < 30
    counter += 1
    timeout = 0
    if counter < 10
      timeout = 50
    else if counter < 20
      timeout = 100
    else if counter < 25
      timeout = 200
    else if counter < 29
      timeout = 300
    else
      timeout = 500

    word = "<i>" + get_random_word_from_all_word() + "</i>"
    console.log "display: counter " + counter + " " + timeout + " " + word
    $('#word').html(word)
    setTimeout callback, timeout
  
    duration = timeout / 1500 + 's'
    $('#word').css({'animation-duration':  duration});
    $('#word').removeClass('fadeInDown animated').addClass('fadeInDown animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', remove_animation)

  else
    word = "<em>" + get_random_word_from_word() + "</em>"
    #words = $('#words').val().split("\n")
    #words.remove(word)
    #$('#words').val(words.join("\n"))
    answer_words.remove(word)
    console.log "answer_words: " + answer_words
    $('#word').html(word)
    $('#word').css({'animation-duration': '1s'});
    $('#word').removeClass('fadeInDown animated').addClass('fadeInDown animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', remove_animation)

remove_animation = ->
  console.log ("remove_animation")
  $('#word').removeClass("fadeInDown animated")
  #setTimeout display, 50

$(document).keypress (e) ->
  console.log "keypress: " + e.which
  if e.which == 13
    counter = 0
    setTimeout callback, 50

$(document).on "page:change", ->
  $('#submit').click ->
    # counter = 0
    # console.log ("hello2")
    # console.log $('#word').html()
    # words = $('#words').val().split("\n")
    # console.log words.length
    # index = Math.floor(Math.random() * words.length)
    # console.log "index " + index
    # word = words[index]
    # words.remove(word)
    # console.log words
    # setTimeout callback, 50

    # testing code
    #$('#word').addClass('animated fadeInDown');
    #$('#words').val(words.join("\n"))
    #$('#word').html('12345')
    #$('#word').attr("class","text-primary");
    #$('#word').html(word)
    #$('#word').css({'animation-duration':  '0.1s'});
    #$('#word').removeClass().addClass('fadeInDown animated').one('webkitAnimationEnd mozAnimationEnd #MSAnimationEnd oanimationend animationend', remove_animation)

    post_value = { 'all_words': $('#all_words').val().split("\n"), \
                   'answer_words': $('#words').val().split("\n") }
    $.post "/randomizer_set_words", post_value, (data) ->
      $('#word').html("all_words: " + data[0] + "<br>answer_words:" + data[1])
