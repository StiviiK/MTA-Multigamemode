Object = {}

function Object:new(...)
	return new(self, ...)
end

function Object:delete(...)
	return delete(self, ...)
end

function Object:load(...)
	return load(self, ...)
end
