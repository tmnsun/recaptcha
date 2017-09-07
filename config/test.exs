use Mix.Config

config :recaptcha,
  http_client: Recaptcha.Http.MockClient
