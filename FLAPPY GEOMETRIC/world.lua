retangulo = require "mundo/objetos/retangulos"	--RETOMA O ARQUIVO QUE CRIA OBJETOS 
canudo = require "inimigo"	--RETOMA O ARQUIVO QUE CRIA INIMIGOS 
audio_back = love.audio.newSource("sounds/backSound.mp3", "stream")
tempo = 0
score = 0
variacao = 0

function worldLoad()
	audio_back:setLooping(true)
	audio_back:play()
	--audio_back:setPitch(0.5) -- one octave lower
	audio_back:setVolume(1)
	love.graphics.setBackgroundColor(0,0.3,0.6)
	retangulo1(retangulo, 400,575,800,50, "inimigo") 
	--[[CRIA RETANGULO INFERIOR DA TELA 
	É UM RETANGULO INIMIGO, SIGNIFICA QUE SE O PERSONAGEM TOCAR MORRE ]]
	retangulo1(retangulo, 400, -26,800,50)
	--[[ RETANGULO SUPERIOR PARA O PERSONAGEM 
	NÃO SAIR DA TELA --]]
	while player.isdeath == true do

	end
end 


function worldUpdate(dt)
	--[[A VARIAVEL TEMPO É ENCREMENTADA DE ACORDO COM O DT
	 + A VARIAÇÃO, QUE INICIALMENTE É 0 ... E ENQUANTO O SCORE FOR %5 == 0 ELE ADCIONA 
	 8 QUE É DIVIDIDO POR UM NUREMO BEM ALTO, JÁ QUE O ENCREMENTO OCORRE EM SEGUNDOS ]]
	tempo = tempo + dt*1.2 + variacao/100000	
	mundo:update(dt)
	mundo:setCallbacks(beginContact, endContact, preSolve, postSolve)
	if math.ceil(tempo)%3==0 then 
		--[[QUANDO O TEMPO FOR DIVISIVEL POR 3,
		ELE ENTRA NO IF, FAZ QUE A VARIAVEL SPAWNED, SEJA FALSA]]
		local spawned = false 
		local posy = math.random(370)-240 --[[A POSIÇÃO É DADA PELO MATH.RANDOM
		...]]
		if not spawned then	
			--[[ENQUANTO O SPAWNED FOR FALSO, ELE ENTRA NESSE SEGUNDO IF 
			E CRIA UM NOVO CANUDO, FAZ COM QUE SPAWNED == TRUE, QUE SIGNIFICA 
			QUE SO CRIARA UM NOVO SE O TEMPO FOR DIVISIVEL POR 3]]
			spawnCanudo(canudo, 831, posy, 60, 500, "inimigo", variacao)
			spawned = true
		end
		tempo = tempo + 1
	end

	for i=1, #canudo do -- PARA CADA CANUDO
		--MOVIMENTAÇÃO DOS RETANGULOS
	--[[NESSE "for" ELE FAZ QUE OS RETANGULOS MUDE DE POSIÇÃO POR SEGUNDO
	E MUTIPLICA PELA VELOCIDADE DO CANUDO]]
		local x, y = canudo[i].body:getPosition()
		canudo[i].body:setPosition(x-dt*canudo[i].speed,y)
	end
	for i=1, #canudo do -- PARA CADA CANUDO
		if canudo[i] then
			local x, y = canudo[i].body:getPosition() --[[AQUI É PEGO O X E Y 
			DOS CANUDOS E FEITO UM IF (SE A POSIÇÃO X DO CANUDO FOR MENOR QUE A POSIÇÃO
		DO PLAYER, FAÇA QUE SCORE SEJA IMPLEMENTADO ) ]]
			if x < player.posInicialX and not canudo[i].scored then
				canudo[i].scored = true
				--[[OBS: O SCORE ESTÁ SENDO IMLEMENTADO POR 0.5, 
				PORQUE ELE PEGA A POSIÇÃO DOS DOIS RETANGULOS E IMPLEMENTA...
				NO CASO SE FOSSE 1 ... ELE CONTARIA DE 2 EM 2 ]]
				score = score + (1/2)
				if score%5 == 0 and variacao < 60 then --DIMINUINDO VARIACAO DE PASSAGEM DOS CANUDOS
					variacao = variacao + 8
					--[[A PARTE MELHOR DO CÓDIGO:
					AQUI QUANDO SCORE FOR UM NÚMERO DIVISIVEL POR 5,
					ELE FAZ QUE A VARIAÇÃO SEJE IMPLEMENTADA]]
					--[[COMO VIMOS LÁ EM CIMA A VARIAÇÃO ESTA PRESENTE NO TEMPO, FAZENDO QUE O SPAWN FIQUE 
					MAIS RÁPIDO E NO ESPAÇO PARA PASSA O PLAYER ENTRE UM CANUDO E OUTRO]]
				end
				if x < -31 then
					--[[APÓS SAIR DA TELA OS CANUDOS SÃO REMOVIDOS
					POIS ISSO CAUSARIA UMA CONSUMO EXECIVO DE MEMORIA]]
					canudo[i].body:destroy()
					table.remove(canudo, i)
				end
			end
		end 
	end 
end 

function worldDraw()
	
	for i=1, #retangulo do -- DESENHANDO TODOS OS RETANGULOS
		drawRetangulo(retangulo[i], "fill")
	end
	for i=1, #canudo do -- DESENHANDO TODOS OS CANUDOS
		if canudo[i] then
			drawCanudo(canudo[i],"line")
			drawCanudo(canudo[i],"fill")
		end
	end
end

metro = 64
love.physics.setMeter(metro)
return love.physics.newWorld(0 , metro*16) -- GRAVIDADE DO MUNDO










