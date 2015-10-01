MYSQL_HOST	= "localhost"
MYSQL_PORT	= 3306
MYSQL_USER	= "root"
MYSQL_PW	  = ""
MYSQL_DB	  = "multigm"

USE_REMOTE_API = false
CHECK_FOR_UPDATES = true
API_URL = "stivik.jusonex.net/multigm/api"
VERSION_URL = "stivik.jusonex.net/multigm/version"

CheatSeverity = {Low = 1, Middle = 2, High = 3, Brutal = 4}
local r2 = {}
for k, v in pairs(CheatSeverity) do
	r2[k] = v
	r2[v] = k
end
CheatSeverity = r2

CheatOffense = {
  PositionDesync = {Name = "Position-Desync", Severity = CheatSeverity.Middle};
  RotationDesync = {Name = "Rotation-Desync", Severity = CheatSeverity.Low};
  FakeData       = {Name = "Fake-Data", Severity = CheatSeverity.Brutal};
}
