# COLA

JavaScript Node-API port of the [Adaptagrams](http://www.adaptagrams.org/) project, using [emnapi](https://emnapi-docs.vercel.app/).

## Usage

```js
import instantiate from '@diegosogari/cola'
const cola = await instantiate();
// see dist/cola.d.ts
```

## Build

```sh
sudo apt install automake cmake g++ git libpcre2-dev python3
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install --lts && nvm use --lts # use latest LTS
git clone https://github.com/diegosogari/cola.git
cd cola && npm run help # see available commands
```
