defaults = require "./defaults"

module.exports = class GetLocale
  middleware: (name) -> require("./#{name}")(@)
  constructor: (o) ->
    for k,v of defaults
      @[k] = v
    for k,v of o
      @[k] = v
    return @
  getLocale: (ctx) ->
    return ctx.__getLocale if ctx.__getLocale
    for toTest in @priority
      break if (result = @match(@["_"+toTest](ctx)))?
    result ?= @default
    return ctx.__getLocale = result
  match: (arr) ->
    if arr?
      unless Array.isArray(arr)
        return @matchStr(arr) || null
      else
        for s in arr
          if (result = @matchStr(s))
            return result
    return null
  matchStr: (str) ->
    if @simplify
      str = @toSimple(str)
    return @supported.indexOf(str) > -1 && str
  toSimple: (str) -> str.split("-")[0]
  lazy: (ctx) -> @getLocale.bind(@,ctx)
  