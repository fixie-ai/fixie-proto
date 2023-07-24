# fixie-proto
This repository contains protocol buffer definitions for working with the Fixie platform. The intention is for this to define our public-facing APIs. Tooling in this repository should then make it easy to use the *already compiled* protos in various languages.

## Usage

### Buf Schema Registry (BSR)

For languages supported by the Buf Schema Registry, instructions for adding these protos like a normal dependency can be found [here](https://buf.build/fixie-ai/fixie/assets/main).  For example, to add a TypeScript dependency using yarn:

```
yarn config set npmScopes.buf.npmRegistryServer https://buf.build/gen/npm/v1/
yarn add @buf/fixie-ai_fixie.bufbuild_connect-es@latest
```

As of July 2023, BSR has support for JavaScript/Typscript, Go, JVM-based languages like Java and Kotlin, and Swift.

### Directly supported languages

We also support additional languages (albeit with fewer options) directly. In particular, Python is available via pip: [PyPI](https://pypi.org/project/fixie-proto/).

```
pip install fixie-proto
```

### Inclusion in a proto library

The easiest way to depend on Fixie protos for your own proto library is by building with [Buf](https://buf.build/docs/introduction/) and adding `buf.build/fixie-ai/fixie` as a dependency in your buf.yaml.

If you're using protoc instead, consider including this repository as a submodule in your own repository.


### Other languages

Buf can be used to easily compile our protos in other languages too, including: Ruby, Objective-C, PHP, C#, Scala, C++, Dart, and Rust.  You'll need to create a [buf.gen.yaml file](https://buf.build/docs/generate/overview/) that uses the relevant protoc plugin for your language. You can also define language-specific proto options without modifying the proto files themselves using [managed mode](https://buf.build/docs/generate/managed-mode/#managed). You can then compile the protos in your language of choice by running:

```
buf generate --template buf.gen.yaml buf.build/fixie-ai/fixie
```

If you'd prefer to use protoc, see the advice above about including Fixie protos in your own proto library.

## Using JSON instead

If you'd prefer not to deal with protos, we've got you covered! All of our APIs can accept and return JSON instead. Just set your Content-Type header to `application/json` instead of `application/proto`.

Our OpenAPI spec matches the proto API. You can view it [here](https://petstore.swagger.io/?url=https://gist.githubusercontent.com/mdepinet/1382c315186d178f587f3d9ca382b74e/raw/be61192d0fe190e646cc52a494017ba7dbe3a33b/loader.swagger.json).

<!-- TODO(mdepinet): Figure out how/where to publish the generated OpenAPI and then link to that here. -->


## Contributing

### Tools

To work in this repository, you'll need to install Buf and Just. If you are using homebrew:

```
brew install bufbuild/buf/buf
brew install just
```

Otherwise see [the Buf docs](https://buf.build/docs/installation/) and [the Just docs](https://just.systems/man/en/chapter_4.html) for other installation options.

### Presubmit

Please run "just" before sending PRs. This will format and lint your proto files in addition to identifying breaking changes. (These will also be run for you any time a PR is created.)

### Releases

New versions are pushed to BSR whenever a PR is merged into main. These events will also cause a push to PyPI as long as the version in pyproject.toml was incremented.
