###
### Build the releae
###
FROM hexpm/elixir:1.12.1-erlang-24.0.1-alpine-3.13.3 AS build

RUN apk add --no-cache build-base npm

WORKDIR /app

ENV HEX_HTTP_TIMEOUT=20

RUN mix local.hex --force && \
	mix.local.rebar --force

ENV MIX_ENV=prod
ENV SECRET_KEY_BASE=nokey

COPY mix.exs mix.lock ./
COPY config config

COPY assets/package.json assets/package-lock/json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets

RUN npm run --prefix ./assets deploy
RUN mix phx.digest

COPY lib lib

COPY rel rel
RUN mix do compile, release


###
### Second stage
###
FROM alpine:3.13.3 AS app
RUN apk add --no-cache libstdc++ openssl ncurses-libs

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/tetris ./

ENV HOME=/app
ENV MIX_ENV=prod
ENV SECRET_KEY_BASE=nokey
ENV PORT=4000

CMD [ "/bin/tetris", "start" ]