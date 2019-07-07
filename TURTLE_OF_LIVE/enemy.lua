--CRIAÇÃO DE CANUDO
function newStraw(posx,posy,width,height,name,type)
    local straw = {}
        straw.speed = 200;  -- VELOCIDADE DO CANUDO 
        straw.scored = false -- SCORE 
        -- FISICA DOS CANUDOS 
        straw.body = love.physics.newBody(world, posx,posy,type)
        straw.shape = love.physics.newRectangleShape(width,height)
        straw.fixture = love.physics.newFixture(straw.body, straw.shape)
        straw.fixture:setUserData(name or 'enemy')

    return straw
end
function spawnStraw(list, posx, posy, width, height, name, variacao)
    -- TABELA DE COMO OS CANUDOS VÃO SPAWNAR 
    local spaceStraw = 200-- ESPASSAMENTO ENTRE OS DOIS CANUDOS 
    local  rectangleHeight = 500
    table.insert(list,newStraw(posx,posy,width,height, name))
    table.insert(list,newStraw(posx,posy+rectangleHeight+spaceStraw-variation,width,height, name))
    
end

-- DESENHAR CANUDO
function drawStraw(a,type)
    love.graphics.draw(image_straw, a.body:getX()+60,a.body:getY()-247, 0 ,1,1, 90 ,0)
    love.graphics.setColor(1,1,1)	
    --love.graphics.polygon(type or "line", a.body:getWorldPoints(a.shape:getPoints()))
    
end

return {}