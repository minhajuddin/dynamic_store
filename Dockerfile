# build the release
FROM bitwalker/alpine-elixir:1.5.1 as builder
ENV MIX_ENV=prod
WORKDIR /opt/build
COPY . /opt/build
RUN mix release \
  ls /opt/build/_build/prod/rel/dynamic_store/releases/*/dynamic_store.tar.gz

# copy the build into a new docker instance and spin it up
FROM bitwalker/alpine-elixir:1.5.1
EXPOSE 5000
ENV PORT=5000
WORKDIR /opt/app
#USER default
COPY --from=builder /opt/build/_build/prod/rel/dynamic_store/releases/*/dynamic_store.tar.gz .
RUN tar xzf dynamic_store.tar.gz && \
  rm dynamic_store.tar.gz
CMD ./bin/dynamic_store foreground
