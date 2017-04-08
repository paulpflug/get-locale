# get-locale

versatile locale parsing for servers.

Comes with middleware for `koa`.

Adapted from [koa-locale](https://github.com/koa-modules/locale).

### Install

```sh
npm install --save get-locale
```

### Usage

```js
Locale = require("get-locale")
locale = new Locale(options)

// KOA
koa.use(locale.middleware("koa"))
koa.use((ctx, next) => {
  locale = ctx.getLocale() // is evaluated lazily
})
```

### Options
```js
supported: ["en"]
default: "en"
simplify: true // "en-US" => "en"
// local options to use:
// default is only "header"
priority: ["query","cookie","url","header","sub","TLD"] 
// TLD: domain.de
// sub: de.domain
// url: domain.de/en
// query: domain.de/?locale=en
// cookie: (in cookie) locale=en
// header: Accept-Language: de, en

// for TLD parsing
// lookup table
TLD: {
  org: "en"
  com: "en"
}

// for query parsing
query: "locale" // => ?locale=en

// for cookie parsing
cookie: "locale" // (in cookie) locale=en

// for url parsing
// position in url
url: 0 // => domain.org/en/other/path
```


## License
Copyright (c) 2017 Paul Pflugradt
Licensed under the MIT license.
