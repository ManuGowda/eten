FROM elixir:1.5.1
MAINTAINER Manu Gowda <manugowda.ns@gmail.com>

ARG MIX_ENV
ENV MIX_ENV ${MIX_ENV:-prod}

WORKDIR /apps
ADD . .

#Compile app
RUN mix local.rebar && \
    mix local.hex --force && \
    mix deps.get && \
    mix compile

#Run the app
EXPOSE 4000
CMD mix ecto.create --quiet && \
    mix ecto.migrate && \
    elixir -pa _build/${MIX_ENV}/consolidated -S mix phx.server
