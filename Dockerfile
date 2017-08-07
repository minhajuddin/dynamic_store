# build the release
FROM bitwalker/alpine-elixir:1.5.1 as builder
ENV MIX_ENV=prod
WORKDIR /opt/build
COPY . /opt/build
RUN mix release \
  ls /opt/build/_build/prod/rel/dynamic_store/releases/*/dynamic_store.tar.gz

FROM bitwalker/alpine-elixir:1.5.1
WORKDIR /opt/app
COPY --from=builder /opt/build/_build/prod/rel/dynamic_store/releases/*/dynamic_store.tar.gz .
RUN apk --no-cache add ca-certificates && \
  tar xzf dynamic_store.tar.gz && \
  rm dynamic_store.tar.gz
CMD ["bin/dynamic_store", "foreground"]

# copy the build into a new docker instance and spin it up

# Set exposed ports
#EXPOSE 5000
#ENV PORT=5000

#ENV MIX_ENV=prod

#ADD yourapp.tar.gz ./
#RUN tar -xzvf yourapp.tar.gz

#USER default

#CMD ./bin/yourapp foreground
