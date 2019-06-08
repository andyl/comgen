use Mix.Config

if Mix.env() == :dev do
  config :mix_test_watch, clear: true
end

import_config "comspecs/#{Mix.env()}*.exs"
