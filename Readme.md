Downloads a recipe from Calibre and emails it to a specified address.

You'll need to set the following env vars, via `--env` or `--env-file`:

    RECIPE
    EMAIL_FROM_USERNAME
    EMAIL_FROM_PASSWORD
    EMAIL_FROM_RELAY
    EMAIL_FROM_PORT
    EMAIL_FROM
    EMAIL_TO

Additionally, if the env var `VERBOSE` is set to any non-empty value, Calibre will run in verbose mode.
