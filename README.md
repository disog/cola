# COLA

JavaScript Node-API port of the [Adaptagrams](http://www.adaptagrams.org/) project, using [emnapi](https://emnapi-docs.vercel.app/).

## Build

### Prerequisites

- [Automake](https://www.gnu.org/software/automake/#downloading)
- [CMake](https://cmake.org/download/)
- C++ compiler toolchain
- [Git](https://git-scm.com/downloads)
- [Emscripten](https://emscripten.org/docs/getting_started/downloads.html)
- [NVM](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)
- [PCRE2](https://github.com/PCRE2Project/pcre2) (for building SWIG)

### Linux

```sh
# install prerequisites
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
git clone https://github.com/emscripten-core/emsdk.git && cd emsdk && \
  ./emsdk install latest && ./emsdk activate latest && source ./emsdk_env.sh && cd ..
sudo apt install automake cmake git g++ libpcre2-dev

nvm install --lts && nvm use --lts # setup NPM
npm install -g @types/node emnapi node-addon-api node-gyp typescript # for building SWIG
git clone https://github.com/diegosogari/cola.git # get the sources
cd cola && npm run help # see list of available commands
```

## Usage

```js
import createModule from '@diegosogari/cola'

const module = await createModule();
// ...
```
