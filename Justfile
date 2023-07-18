# This is the main Justfile for the Fixie proto repo.
# To install Just, see: https://github.com/casey/just#installation

# This causes the .env file to be read by Just.
set dotenv-load := true

# Allow for positional arguments in Just receipes.
set positional-arguments := true

# Default recipe that runs if you type "just".
default: format lint check

# Install dependencies for local development.
install:
    cd src/frontend && npm install
    pip install poetry==1.2.1
    poetry install --sync

# Format code.
format:
    buf format -w

# Lint code.
lint:
    buf lint

# Check for breaking API changes.
check:
    buf breaking --against '.git#branch=main'

# Check for breaking API changes against the remote main branch.
check-repo-head:
    buf breaking --against 'https://github.com/fixie-ai/fixie-proto.git'

# Run the poetry command with the local .env loaded.
poetry *FLAGS:
    poetry {{FLAGS}}

# Generate Python code and build a wheel.
build-python:
    buf generate --template buf.gen.py.yaml
    find gen/python -type d -exec touch {}/__init__.py \;
    poetry build

# TODO(mdepinet): Re-enable once we have a PyPI team and package.
# Publish wheel to PyPI.
# This uses the PyPI API Token stored in the Google Cloud Secrets Manager, which you need
# access to in order to publish the wheel.
#publish: build-python
#    poetry publish -u __token__ -p $(gcloud secrets versions access --secret=fixie-sdk-pypi-api-token latest)
