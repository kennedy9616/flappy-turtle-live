rectangle = require "world/objects/rectangles"	--RETOMA O ARQUIVO QUE CRIA OBJETOS 
straw = require "enemy"	--RETOMA O ARQUIVO QUE CRIA INIMIGOS 

audio_back = love.audio.newSource("sounds/backSound.mp3", "stream")

time = 0 -- TEMPO 
score = 0 --PONTUAÇÃO
variation = 0 --VARIAÇÃO DA DIFICULDADE 

function worldLoad()
	--[[MUSICA DE FUNDO]]
	audio_back:setLooping(true)
	audio_back:play()
	--audio_back:setPitch(0.5) -- one octave lower
	audio_back:setVolume(1)

	background = love.graphics.newImage("image/beach.png") -- IMAGEM DE FUNDO 

	love.graphics.setBackgroundColor(0,0.3,0.6)
	rectangle1(rectangle, 400,575,800,50, "enemy") 
	--[[CRIA RETANGULO INFERIOR DA TELA 
	É UM RETANGULO INIMIGO, SIGNIFICA QUE SE O PERSONAGEM TOCAR MORRE ]]
	rectangle1(rectangle, 400, -26,800,50)
	--[[ RETANGULO SUPERIOR PARA O PERSONAGEM 
	NÃO SAIR DA TELA --]]
end 


function worldUpdate(dt)
	--[[A VARIAVEL TEMPO É ENCREMENTADA DE ACORDO COM O DT
	 + A VARIAÇÃO, QUE INICIALMENTE É 0 ... E ENQUANTO O SCORE FOR %5 == 0 ELE ADCIONA 
	 8 QUE É DIVIDIDO POR UM NUREMO BEM ALTO, JÁ QUE O ENCREMENTO OCORRE EM SEGUNDOS ]]
	
	 time = time + dt*1.2 + variation/10000 --[[A MUTIPLICAÇÃO AUMENTA
	 A DIVISÃO DIMINUI, SE QUISER DEIXAR A VARIAÇÃO MAIOR .. SO DIMINUIR O DENOMINADOR]]

	world:update(dt)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
	
	if math.ceil(time)%3==0 then 
		--[[QUANDO O TEMPO FOR DIVISIVEL POR 3,
		ELE ENTRA NO IF, FAZ QUE A VARIAVEL SPAWNED, SEJA FALSA]]
		local spawned = false 
		local posy = math.random(397) - 240 --[[A POSIÇÃO É DADA PELO MATH.RANDOM
		... MENOS UMA VARIÇÃO PARA QUE OS CANUDOS ... TENHAM UM ESPAÇO PARA QUE O PLAYER
		CONSIGA PASSAR ]]
		if not spawned then	
			--[[ENQUANTO O SPAWNED FOR FALSO, ELE ENTRA NESSE SEGUNDO IF 
			E CRIA UM NOVO CANUDO, FAZ COM QUE SPAWNED == TRUE, QUE SIGNIFICA 
			QUE SO CRIARA UM NOVO SE O TEMPO FOR DIVISIVEL POR 3]]
			spawnStraw(straw, 831, posy, 60, 500, "enemy", variation)
			spawned = true
		end
		time = time + 1
	end

	for i=1, #straw do -- PARA CADA CANUDO
		--MOVIMENTAÇÃO DOS RETANGULOS
	--[[NESSE "for" ELE FAZ QUE OS RETANGULOS MUDE DE POSIÇÃO POR SEGUNDO
	E MUTIPLICA PELA VELOCIDADE DO CANUDO]]
		x, y = straw[i].body:getPosition()
		straw[i].body:setPosition(x-dt*straw[i].speed,y)
	end
	for i=1, #straw do -- PARA CADA CANUDO
		if straw[i] then
			x, y = straw[i].body:getPosition() --[[AQUI É PEGO O X E Y 
			DOS CANUDOS E FEITO UM IF (SE A POSIÇÃO X DO CANUDO FOR MENOR QUE A POSIÇÃO
		DO PLAYER, FAÇA QUE SCORE SEJA IMPLEMENTADO ) ]]
			if x < player.posX and not straw[i].scored then
				straw[i].scored = true
				--[[OBS: O SCORE ESTÁ SENDO IMLEMENTADO POR 0.5, 
				PORQUE ELE PEGA A POSIÇÃO DOS DOIS RETANGULOS E IMPLEMENTA...
				NO CASO SE FOSSE 1 ... ELE CONTARIA DE 2 EM 2 ]]
				score = score + (1/2)
				if score%5 == 0 and variation < 64 then 
					--[[DIMINUINDO VARIACAO DE PASSAGEM DOS CANUDOS, POREM SE A VARIAÇÃO 
					FOR MAIOR QUE 60 .. ELE PARA POIS EH O ESPAÇO MAXIMO ONDE O PLAYER AINDA POSSA 
					PASSAR SEM MORRER . ]]
					variation = variation + 8
					--[[A PARTE MELHOR DO CÓDIGO:
					AQUI QUANDO SCORE FOR UM NÚMERO DIVISIVEL POR 5,
					ELE FAZ QUE A VARIAÇÃO SEJE IMPLEMENTADA]]
					--[[COMO VIMOS LÁ EM CIMA A VARIAÇÃO ESTA PRESENTE NO TEMPO, FAZENDO QUE O SPAWN FIQUE 
					MAIS RÁPIDO E NO ESPAÇO PARA PASSA O PLAYER ENTRE UM CANUDO E OUTRO]]
				end
				if x < -31 then
					--[[APÓS SAIR DA TELA OS CANUDOS SÃO REMOVIDOS
					POIS ISSO CAUSARIA UMA CONSUMO EXECIVO DE MEMORIA]]
					straw[i].body:destroy()
					table.remove(straw, i)
				end
			end
		end 
	end 
end 

function worldDraw()
	
	for i = 0, love.graphics.getWidth() / background:getWidth() do
        for j = 0, love.graphics.getHeight() / background:getHeight() do
            love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        end
    end

	for i=1, #straw do -- DESENHANDO TODOS OS CANUDOS
		if straw[i] then
			drawStraw(straw[i])	
		end
	end 
	for i=1, #rectangle do -- DESENHANDO TODOS OS RETANGULOS
		love.graphics.setColor(0.8,0.6,0)
		drawRectangle(rectangle[i], "fill")
		love.graphics.setColor(1,1,1)
	end	
	

end

image_straw = love.graphics.newImage("image/straw.png")

metro = 64
love.physics.setMeter(metro)
return love.physics.newWorld(0 , metro*16) -- GRAVIDADE DO MUNDO










