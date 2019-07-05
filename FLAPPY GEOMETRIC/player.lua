
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
        audio_jump:play()
    end
 end



function playerUpdate(dt)
    if player.fixture:getUserData()=="morto" then
        player.isdeath = true
        audio_lose:play()
        if audio_lose:play() then
        audio_fail:play()
        end
    end
   --anim8:update(dt/1.5)
end 

function playerDraw()
    love.graphics.draw( images,player.body:getX()-20,player.body:getY()-20 )

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

images =    love.graphics.newImage("images/turtle.png")
local g = anim8.newGrid(40,40,images:getWidth(),images:getHeight())
--anim8 = anim8.newAnimation(g('1-5',1,'1-5',2,'1-5',3,'1-5',4,'1-4',5),0.1)

player.body = love.physics.newBody(mundo, player.posInicialX, player.posInicialY , 'static')
player.shape = love.physics.newRectangleShape(player.tamanhoX*player.scaleX,player.tamanhoY*player.scaleY)
player.fixture = love.physics.newFixture(player.body,player.shape,1)
player.fixture:setRestitution(0.1)
player.body:setLinearDamping(player.damping)
player.fixture:setUserData("player")

return player