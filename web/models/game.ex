defmodule Adrenaline.Game do
  @questions  [
    %{
      id: 1,
      question: "What logo corresponds to elixir language?",
      img_1: "/images/01-a.png",
      img_2: "/images/01-b.png",
      answer: "a"
    },
    %{
      id: 2,
      question: "What logo corresponds to Rust language?",
      img_1: "/images/02-a.png",
      img_2: "/images/02-b.png",
      answer: "a"
    },
    %{
      id: 3,
      question: "Which of the following avatars belongs to Robert Jackson?",
      img_1: "/images/03-a.jpeg",
      img_2: "/images/03-b.jpeg",
      answer: "a"
    },
    %{
      id: 4,
      question: "Which Zoey corresponds to the Atlanta meetup?",
      img_1: "/images/04-a.png",
      img_2: "/images/04-b.png",
      answer: "a"
    },
    %{
      id: 5,
      question: "Which logo corresponds to IE7?",
      img_1: "/images/05-a.png",
      img_2: "/images/05-b.png",
      answer: "a"
    }
  ]

  def questions do
    @questions
  end
end
