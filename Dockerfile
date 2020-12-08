# ================================
# Build image
# ================================
FROM swift:5.2-bionic as build
WORKDIR /build

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get install -y libsqlite3-dev nano \
    && rm -rf /var/lib/apt/lists/*

# First just resolve dependencies.
# This creates a cached layer that can be reused
# as long as your Package.swift/Package.resolved
# files do not change.
COPY ./Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY . .

# Compile with optimizations
RUN swift build --enable-test-discovery -c release

# ================================
# Run image
# ================================
FROM swift:5.2-bionic-slim

# Create a vapor user and group with /app as its home directory
RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /app vapor

ARG env
ENV env ${env:-production}

# Switch to the new home directory
WORKDIR /app

# Copy build artifacts
COPY --from=build --chown=vapor:vapor /build/.build/release /app
# Uncomment the next line if you need to load resources from the `Public` directory
# COPY --from=build --chown=vapor:vapor /build/Cert /app/Cert
RUN [ -d /build/Public ] && { mv /build/Public ./Public && chmod -R a-w ./Public; } || true
RUN [ -d /build/Resources ] && { mv /build/Resources ./Resources && chmod -R a-w ./Resources; } || true

# Copy dotenv files
COPY --from=build --chown=vapor:vapor /build/.env /app/.env
COPY --from=build --chown=vapor:vapor /build/.env.production /app/.env.production
#COPY --from=build --chown=vapor:vapor /build/.env.development /app/.env.development
#COPY --from=build --chown=vapor:vapor /build/.env.test /app/.env.test
# Uncomment the next line if you need to load resources from the `Public` directory
COPY --from=build --chown=vapor:vapor /build/Public /app/Public
# Uncomment the next line if you need to load resources from the `Resources` directory
COPY --from=build --chown=vapor:vapor /build/Resources /app/Resources

# Ensure all further commands run as the vapor user
USER vapor:vapor

# Start the Vapor service when the image is run, default to listening on 8080 in production environment
ENTRYPOINT ["./Run"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0", "--port", "8080"]
