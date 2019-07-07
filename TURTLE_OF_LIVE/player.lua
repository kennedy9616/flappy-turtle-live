
audio_jump = love.audio.newSource("sounds/playerJump.mp3", "stream")
audio_lose = love.audio.newSource("sounds/playerLose.mp3", "stream")
audio_fail = love.audio.newSource("sounds/failSound.mp3", "stream")
function playerLoad()

    audio_jump:setLooping(true)
    audio_jump:setVolume(0.1)
    audio_jump:play()

    audio_fail:setLooping(true)
	audio_fail:play()
    audio_fail:setVolume(0.1)
    
    audio_lose:setLooping(true)
    audio_lose:play()
    
end




function love.keypressed( key )
    if key == "space" then
        player.body:setLinearVelocity(0,0)
        player.body:applyForce(0,-player.jump)

        audio_jump:play() -- AUDIO DE SALTO 
    end
 end



function playerUpdate(dt)
    if player.fixture:getUserData()=="death" then
        player.isdeath = true

        audio_lose:play() -- AUDIO DE MORTE LOSE 
        
        if audio_lose:play() then

            audio_fail:play() -- AUDIO DE MORTE 

        end
    end
end 

function playerDraw()
    --drawRetangulo(player)
    love.graphics.draw(image,player.body:getX()+70*player.scaleX,player.body:getY()-20*player.scaleY, 0 , player.scaleX, player.scaleY, 90, 0)

end 

player = {}

player.live = 100   -- VIDA DO PLAYER 

player.posX = 300   -- POSIÇÃO EM QUE O PLAYER NASCE
player.posY = 300 

player.sizeX = 40   -- TAMANHO X E Y DO PLAYER 
player.sizeY = 40

player.scaleX = 1   -- ESCALA DO PLAYER DOBRA OU TRIPLICA O TAMANHO
player.scaleY = 1   -- PORÉM AUMENTA A DENSIDADE DO PLAYER 

player.jump = 10600 -- FORÇA DE SALTO 

player.damping = 0.2 -- AMORTECIMENTO 

player.isdynamic = false -- PLAYER DINAMICO OU ESTATICO 
player.isdeath = false  -- SE O PLAYER TA MORTO 
player.menudeath = false -- MENU APÓS MORTE DO PLAYER 

image =    love.graphics.newImage("image/turtle.png")
-- FISICA DO PLAYER 
player.body = love.physics.newBody(world, player.posX, player.posY , 'static')
player.shape = love.physics.newRectangleShape(player.sizeX*player.scaleX,player.sizeY*player.scaleY)
player.fixture = love.physics.newFixture(player.body,player.shape,1)
player.fixture:setRestitution(0.1)
player.body:setLinearDamping(player.damping)
player.fixture:setUserData("player")

return player
