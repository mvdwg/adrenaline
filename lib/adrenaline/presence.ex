defmodule Adrenaline.Presence do
  use Phoenix.Presence, otp_app: :adrenaline,
                        pubsub_server: Adrenaline.PubSub
end
