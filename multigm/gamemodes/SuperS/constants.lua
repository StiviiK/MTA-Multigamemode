RNS_DOWNLOAD_FILE = "gamemodes/SuperS/supers.data"

-- Item Types
SUPERS_ITEM_TYPE_NOTHING = toHex(crc32("SUPERS_ITEM_TYPE_NOTHING")) --0
SUPERS_ITEM_TYPE_BOOST = toHex(crc32("SUPERS_ITEM_TYPE_BOOST")) --1
SUPERS_ITEM_TYPE_JUMP = toHex(crc32("SUPERS_ITEM_TYPE_JUMP")) --2
SUPERS_ITEM_TYPE_REPAIR = toHex(crc32("SUPERS_ITEM_TYPE_REPAIR")) --3
SUPERS_ITEM_TYPE_ROCKET = toHex(crc32("SUPERS_ITEM_TYPE_ROCKET")) --4
SUPERS_ITEM_TYPE_WEAPON = toHex(crc32("SUPERS_ITEM_TYPE_WEAPON")) --5
SUPERS_ITEM_TYPE_MAGICCHEST = toHex(crc32("SUPERS_ITEM_TYPE_MAGICCHEST")) --6

SUPERS_ITEM_MAGICCHEST_BURN_SELF = toHex(crc32("SUPERS_ITEM_MAGICCHEST_BURN_SELF")) --1
SUPERS_ITEM_MAGICCHEST_BURN_OTHER = toHex(crc32("SUPERS_ITEM_MAGICCHEST_BURN_OTHER")) --2

-- Weapons
WEAPONS = {
  [22] = {Id = 22, Model = 346, Name="colt 45", x=0, y=1.7, z=0, rx=0, ry=10, rz=90, fx=0, fy=-10, fz=0},
  [23] = {Id = 23, Model = 347, Name="silenced", x=0, y=1.7, z=0, rx=0, ry=10, rz=90, fx=0, fy=-10, fz=0},
  [24] = {Id = 24, Model = 348, Name="deagle", x=0, y=1.6, z=0, rx=0, ry=5, rz=95, fx=0, fy=-4, fz=-5},
  [28] = {Id = 28, Model = 352, Name="uzi", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [29] = {Id = 29, Model = 353, Name="mp5", x=0, y=1.5, z=0, rx=0, ry=10, rz=90, fx=0, fy=-10, fz=0},
  [30] = {Id = 30, Model = 355, Name="ak-47", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [31] = {Id = 31, Model = 356, Name="m4", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [32] = {Id = 32, Model = 372, Name="tec-9", x=0, y=1.6, z=0, rx=0, ry=5, rz=93, fx=0, fy=-5, fz=-3},
  [38] = {Id = 38, Model = 362, Name="minigun", x=0, y=1.4, z=0, rx=-3, ry=30, rz=93, fx=0, fy=-30, fz=-3},
}
