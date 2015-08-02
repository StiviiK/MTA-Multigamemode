-- Caching for custom dxFonts
function Font (fontname, fontsize)
  local cache = getCache("font")
  if not cache[fontname] then
    cache[fontname] = {}
  end
  if not cache[fontname][fontsize] then
  		cache[fontname][fontsize] = dxCreateFont(("files/fonts/%s"):format(fontname), fontsize)
  end

  return cache[fontname][fontsize]
end
