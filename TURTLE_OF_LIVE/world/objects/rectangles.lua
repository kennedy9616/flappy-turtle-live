function newRectangle(posx,posy,width,height,name,type)
	local rectangle = {}
	-- FISICA DOS RETANGULOS 
	rectangle.body = love.physics.newBody(world, posx,posy,type)
	rectangle.shape = love.physics.newRectangleShape(width,height)
	rectangle.fixture = love.physics.newFixture(rectangle.body, rectangle.shape)
	rectangle.fixture:setUserData(name or 'rectangle')

	return rectangle
end 
-- DESENHA OS RETANGULOS 
function drawRectangle(a,type)
	love.graphics.polygon(type or "line", a.body:getWorldPoints(a.shape:getPoints()))
end
-- CRIA OS RETANGULOS 
function rectangle1 (rectangle, posx, posy, width, height, name)
	rectangle[#rectangle + 1] = newRectangle(posx,posy,width,height, name) 
end
return {}
