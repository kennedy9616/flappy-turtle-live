--CRIAÇÃO DE CANUDO
function newCanudo(posx,posy,largura,altura,name,tipo)
    local canudo = {}
        canudo.speed = 200;  -- VELOCIDADE DO CANUDO 
        canudo.scored = false -- SCORE 
        canudo.body = love.physics.newBody(mundo, posx,posy,tipo)
        canudo.shape = love.physics.newRectangleShape(largura,altura)
        canudo.fixture = love.physics.newFixture(canudo.body, canudo.shape)
        canudo.fixture:setUserData(name or 'inimigo')
    return canudo
end
function spawnCanudo(lista, posx, posy, largura, altura, name, variacao)
    table.insert(lista,newCanudo(posx,posy,largura,altura, name))
    table.insert(lista,newCanudo(posx,posy+500+200-variacao,largura,altura, name))
end

-- DESENHAR CANUDO
function drawCanudo(a,tipo)
	love.graphics.polygon(tipo or "line", a.body:getWorldPoints(a.shape:getPoints()))
end


return {}