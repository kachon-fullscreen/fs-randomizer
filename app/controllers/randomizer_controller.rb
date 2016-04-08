class RandomizerController < ApplicationController

  def index
  end

  def get_words
    redis = Redis.new
    all_words = redis.get("randomizer_all_words")
    answer_words = redis.get("randomizer_answer_words")

    all_words = all_words.nil? ? [] : JSON.parse(all_words)
    answer_words = answer_words.nil? ? [] : JSON.parse(answer_words)
    words = [all_words, answer_words]
    render json: words
  end

  def set_words_api
    all_words = params["all_words"]
    answer_words = params["answer_words"]
    redis = Redis.new
    redis.set("randomizer_all_words", all_words.to_json)
    redis.set("randomizer_answer_words", answer_words.to_json)
    render json: [all_words, answer_words]
  end

  def set_words
  end

end
