-------------------------------------------------------------------------------
-- Drawable image type
-------------------------------------------------------------------------------
-- @classmod yae.Image

Texture = yae.java.require "com.badlogic.gdx.graphics.Texture"
Constants = require "yae.constants"

class
  new: (filename, format="rgba8", filetype) =>
    file = yae.File(filename, filetype)
    @texture = yae.java.new Texture, file.file, Constants.formats[format], false
    @texture\setFilter Constants.filters["linear"], Constants.filters["linear"]

  getDimensions: =>
    @getWidth!, @getHeight!

  getFilter: =>
    min_filter = @texture\getMinFilter!
    mag_filter = @texture\getMagFilter!
    Constants.filtercodes[min_filter], Constants.filtercodes[mag_filter]

  getFormat: =>
    texture_data = @texture\getTextureData!
    format = texture_data\getFormat!
    Constants.formatcodes[format]

  getHeight: =>
    @texture\getHeight!

  getWidth: =>
    @texture\getWidth!

  getWrap: =>
    Constants.wraps[@texture\getUWrap!], Constants.wraps[@texture\getVWrap!]

  setFilter: (min, mag) =>
    @texture\setFilter Constants.filters[min], Constants.filters[mag]

  setWrap: (horiz, vert) =>
    @texture\setWrap Constants.wraps[horiz], Constants.wraps[vert]

  free: =>
    @texture\dispose!
