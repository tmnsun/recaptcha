# Recaptcha

A simple Elixir package for implementing [reCAPTCHA] in Elixir applications.

[reCAPTCHA]: http://www.google.com/recaptcha

## Installation

1. Add recaptcha to your `mix.exs` dependencies

```elixir
  defp deps do
    [
      {:recaptcha, github: "tmnsun/recaptcha"},
    ]
  end
```

2. List `:recaptcha` as an application dependency

```elixir
  def application do
    [ applications: [:recaptcha] ]
  end
```

3. Run `mix do deps.get, compile`

## Usage

### Verify API

Recaptcha provides the `verify/2` method. Below is an example using a Phoenix controller action:

```elixir
  def create(conn, params) do
    case Recaptcha.verify(params["g-recaptcha-response"], [secret: secret_api_key]) do
      {:ok, response} -> do_something
      {:error, errors} -> handle_error
    end
  end
```

`verify` method sends a `POST` request to the reCAPTCHA API and returns 2 possible values:

`{:ok, %Recaptcha.Response{challenge_ts: timestamp, hostname: host}}` -> The captcha is valid, see the [documentation](https://developers.google.com/recaptcha/docs/verify#api-response) for more details.

`{:error, errors}` -> `errors` contains atomised versions of the errors returned by the API, See the [error documentation](https://developers.google.com/recaptcha/docs/verify#error-code-reference) for more details. Errors caused by timeouts in HTTPoison or Poison encoding are also returned as atoms. If the recaptcha request succeeds but the challenge is failed, a ``:challenge_failed` error is returned.

`verify` method also accepts a keyword list as the third parameter with the following options:

Option                  | Action                                                 | Default
:---------------------- | :----------------------------------------------------- | :------------------------
`timeout`               | Time to wait before timeout                            | 5000 (ms)
`secret`                | Private key to send as a parameter of the API request  | no default
`remote_ip`             | Optional. The user's IP address, used by reCaptcha     | no default

## Contributing

Check out [CONTRIBUTING.md](/CONTRIBUTING.md) if you want to help.

## License

[MIT License](http://www.opensource.org/licenses/MIT).
