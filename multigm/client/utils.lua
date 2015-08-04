function getElementBehindCursor(worldX, worldY, worldZ)
    local x, y, z = getCameraMatrix()
    local hit, hitX, hitY, hitZ, element = processLineOfSight(x, y, z, worldX, worldY, worldZ, false, true, true, true, false)

    return element
end
