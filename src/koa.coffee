util = require "util"
module.exports = (getLocale) -> 
  getLocale._query = (ctx) -> ctx.query[@query]
  getLocale._sub = (ctx) -> ctx.subdomains?[0]
  getLocale._header = (ctx) -> ctx.acceptsLanguages()
  getLocale._cookie = (ctx) -> ctx.cookies.get(@cookie)
  getLocale._url = (ctx) -> 
    a = ctx.path.substring(1).split("/")
    if a.length > @url
      return a[@url]
    return null
  getLocale._TLD = (ctx) -> 
    ext = ctx.hostname.split(".").pop()
    return @TLD[ext] || ext
  return (ctx, next) ->
    ctx.getLocale = getLocale.lazy(ctx)
    next()