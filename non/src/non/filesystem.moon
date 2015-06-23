c = require("non.internal.common")
lua = c.vm.lua
helpers = c.vm.helpers

{
  newFile: (filename, filetype="internal") ->
    switch filename
      when "internal"
        return gdx.files\internal filename
      when "local"
        return helpers\localfile filename
      when "external"
        return gdx.files\external filename
      when "classpath"
        return gdx.files\classpath filename
      when "absolute"
        return gdx.files\absolute filename

  append: (filename, text, filetype) ->
    file = @newFile filename, filetype
    file\writeString text, true
    return true

  copy: (from_filename, to_filename, from_filetype, to_filetype) ->
    from_file = @newFile from_filename, from_filetype
    to_file = @newFile from_filename, from_filetype
    from_file\copyTo to_file
    return true

  createDirectory: (filename, filetype) ->
    file = @newFile filename, filetype
    @newFile\mkdirs!
    return true

  exists: (filename, filetype) ->
    file = @newFile filename, filetype
    return @newFile\exists!

  getDirectoryItems: (filename, filetype) ->
    children = @newFile(filename, filetype)\list!
    paths = {}

    for i = 0, children.length
      paths[i + 1] = children[i]\path!

    return paths

  getExternalDirectory: ->
    return gdx.files\getExternalStoragePath!

  getLocalDirectory: ->
    return gdx.files\getLocalStoragePath!

  getWorkingDirectory: ->
    file = @newFile(".")\file!
    return file\getAbsolutePath!

  getLastModified: (filename, filetype) ->
    file = @newFile filename, filetype
    return file\lastModified!

  getSize: (filename, filetype) ->
    file = @newFile filename, filetype
    return file\length!

  isDirectory: (filename, filetype) ->
    file = @newFile filename, filetype
    return file\isDirectory!

  isFile: (filename, filetype) ->
    return not @isDirectory filename, filetype

  load: (filename, filetype) ->
    file = @newFile filename, filetype
    return lua\load file\reader!, filename

  move: (from_filename, to_filename, from_filetype, to_filetype) ->
    from_file = @newFile from_filename, from_filetype
    to_file = @newFile from_filename, from_filetype
    from_file\moveTo to_file
    return true

  read: (filename, filetype) ->
    file = @newFile filename, filetype
    return file\readString!

  remove: (filename, filetype) ->
    file = @newFile filename, filetype
    file\deleteDirectory!
    return true

  write: (filename, text, filetype) ->
    file = @newFile filename, filetype
    file\writeString text
    return true
}