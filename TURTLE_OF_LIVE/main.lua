math.randomseed(os.time())
world = require "world"
anim8 = require "anim8"
player = require "player"
require "callbacks"
require "conf"

function love.load()
	worldLoad()

	font = love.graphics.newImageFont("image/font.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
	"123456789.,!?-+/():;%&`'*#=[]\"")
	love.graphics.setFont(font)
	love.mouse.setVisible(false) -- TIRA A SETA DO MOUSE DA TELA 
end 

function love.update(dt)
	--[[FAZ COM QUE ENQUANTO A TECLA ESPACE NÃO FOR APERTADA O PLAYER
... NÃO SE MOVA ]]
	if love.keyboard.isDown("space") then 
        player.isdynamic = true;
	end
	--[[TECLA PARA SAIR DO JOGO ]]
	if love.keyboard.isDown("escape") then 
		if player.menudeath then
			love.event.quit()
		end
	end --]]
	--[[DEPOIS QUE O PLAYER MORRER A TECLA "ENTER" SERVE PARA 
	... RECOMEÇAR O JOGO ]]
	if love.keyboard.isDown("return") then 
		if player.menudeath then
			love.event.quit("restart")
		end
	end--]]
	--[[ENQUATO A TECLA ESPACE NÃO FOR APERTADA NADA DO JOGO CARREGA,
	POIS A COMPARAÇÃO NÃO CORRESPONDE O IF ]]
	if (player.isdynamic) and not player.isdeath then
		player.body:setType("dynamic")
		
		worldUpdate(dt)
		playerUpdate(dt)

		audio_back:play()

	elseif player.isdeath then 
	--elseif player.live == 0 then 
		--[[MAS SE O PLAYER MORRER, ATRAVES DESSE IF O MENU DE MORTE É
		ATIVADO CHAMANDO OS QUADROS COM A INFORMAÇÃO ]]
		audio_back:stop()
		audio_jump:stop()
		
		if not player.menudeath then
		 
			rectangleDeath1 =  newRectangle(400, 300, 400, 300)
			rectangleDeath2 =  newRectangle(400, 300, 400, 300)
			rectangleDeath3 =  newRectangle(400, 200, 400, 100)
			rectangleDeath4 =  newRectangle(400, 300, 400, 100)
			rectangleDeath5 =  newRectangle(400, 400, 400, 100)
			player.menudeath = true;
		end
	end


end

function love.draw()
	worldDraw()
	playerDraw()
	love.graphics.print("SCORE: "..score, 30,45,0,1.5,1.5)
	--love.graphics.print("VIDA: "..player.vida.." %", 30 , 75 , 0 , 1.5 ,1.5)
	--[[NESSE IF É SO PARA APARECER ANTES DO JOGO A PALAVRA "PRESS SPACE",
	ISSO SO FUNCIONA POIS ENQUANTO A TECLA "SPACE" NÃO FOR APERTADA
	PLAYER.ISDYNAMIC == FALSE ]]

	if not player.isdynamic  then 
		love.graphics.setColor(1,1,1)
		love.graphics.print("PRESS SPACE",500,300,0,2,2)
	end 
--[[É CHAMADO DEPOIS QUE O PLAYER MORRER, DESENHARÁ OS RETANGULOS COM
INFORMAÇÕES NA TELA ]]
	if player.menudeath then 
			love.graphics.setColor(0.8,0.1,0.1)
			drawRectangle(rectangleDeath1,"fill")
			love.graphics.setColor(1,1,1)
			drawRectangle(rectangleDeath2,"line")
			drawRectangle(rectangleDeath3,"line")
			drawRectangle(rectangleDeath4,"line")
			drawRectangle(rectangleDeath5,"line" )
			love.graphics.setColor(1,1,1)
			love.graphics.print("GAME OVER",320,190,0,2,2)
			love.graphics.print("  ESC  ",345,270,0,2,2)
			love.graphics.print("FOR EXIT",340,300,0,2,2)
			love.graphics.print(" ENTER ",345,370,0,2,2)
			love.graphics.print("FOR RESTART",310,400,0,2,2)
			love.graphics.setColor(1,1,1)

	end

end
