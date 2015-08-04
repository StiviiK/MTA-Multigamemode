function getElementBehindCursor(worldX, worldY, worldZ)
    local hit, hitX, hitY, hitZ, element = processLineOfSight(getCamera():getPosition(), worldX, worldY, worldZ, false, true, true, true, false)
    return element
end
