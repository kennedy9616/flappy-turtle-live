function newRetangulo(posx,posy,largura,altura,name,tipo)
	local retangulo = {}
	retangulo.body = love.physics.newBody(mundo, posx,posy,tipo)
	retangulo.shape = love.physics.newRectangleShape(largura,altura)
	retangulo.fixture = love.physics.newFixture(retangulo.body, retangulo.shape)
	retangulo.fixture:setUserData(name or 'retangulo')

	return retangulo
end 

function drawRetangulo(a,tipo)
	love.graphics.polygon(tipo or "line", a.body:getWorldPoints(a.shape:getPoints()))
end

function retangulo1 (retangulo, posx, posy, largura, altura, name)
	retangulo[#retangulo + 1] = newRetangulo(posx,posy,largura,altura, name) 
end
return {}
