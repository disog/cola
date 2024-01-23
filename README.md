# COLA

JavaScript Node-API port of the [Adaptagrams](http://www.adaptagrams.org/) project, using [emnapi](https://emnapi-docs.vercel.app/).

## Build

### Prerequisites

- [Automake](https://www.gnu.org/software/automake/#downloading)
- [CMake](https://cmake.org/download/)
- C++ compiler toolchain
- [Git](https://git-scm.com/downloads)
- [NVM](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)
- [PCRE2](https://github.com/PCRE2Project/pcre2) (for building SWIG)
- [Python3](https://www.python.org/downloads/)

### Linux

```sh
sudo apt install automake cmake g++ git libpcre2-dev python3
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts && nvm use --lts
npm install -g @types/node emnapi node-addon-api node-gyp typescript
git clone https://github.com/diegosogari/cola.git
cd cola && npm run help
npm install && npm run build && npm test
```

## Usage

```js
import instantiate from '@diegosogari/cola'
const cola = await instantiate();
// see dist/cola.d.ts
```
