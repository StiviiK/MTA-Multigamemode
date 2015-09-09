MYSQL_HOST	= "localhost"
MYSQL_PORT	= 3306
MYSQL_USER	= "root"
MYSQL_PW	  = ""
MYSQL_DB	  = "multigm"

USE_REMOTE_API = true
API_URL = "stivik.jusonex.net/mta/api"

PROVIDER_DOWNLOAD_SPEED = 0.5 * 1024 * 1024
if DEBUG then
  PROVIDER_DOWNLOAD_SPEED = 1 * 1024 * 1024
end
