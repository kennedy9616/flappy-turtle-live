
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
        player.body:applyForce(0,-player.salto)

        audio_jump:play() -- AUDIO DE SALTO 
    end
 end



function playerUpdate(dt)
    if player.fixture:getUserData()=="morto" then
        player.isdeath = true

        audio_lose:play() -- AUDIO DE MORTE LOSE 
        
        if audio_lose:play() then

            audio_fail:play() -- AUDIO DE MORTE 

        end
    end
end 

function playerDraw()
    drawRetangulo(player)
    love.graphics.draw(images,player.body:getX()+70*player.scaleX,player.body:getY()-20*player.scaleY, 0 , player.scaleX, player.scaleY, 90, 0)

end 

player = {}

player.vida = false 
player.vidaMax = player.vida

player.posInicialX = 300
player.posInicialY = 300
player.tamanhoX = 40
player.tamanhoY = 40
player.scaleX = 1
player.scaleY = 1
player.salto = 10600
player.damping = 0.2
player.isdynamic = false
player.isdeath = false 
player.menudeath = false

local fps = 15
local anim_timer = 1
local frame = 1
local num_frames = 6
local xoffset

images =    love.graphics.newImage("images/turtle.png")

player.body = love.physics.newBody(mundo, player.posInicialX, player.posInicialY , 'static')
player.shape = love.physics.newRectangleShape(player.tamanhoX*player.scaleX,player.tamanhoY*player.scaleY)
player.fixture = love.physics.newFixture(player.body,player.shape,1)
player.fixture:setRestitution(0.1)
player.body:setLinearDamping(player.damping)
player.fixture:setUserData("player")

return player