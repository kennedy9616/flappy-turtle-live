
function beginContact(a, b, coll)

    if a:getUserData()=="player" and b:getUserData()=="enemy" then
        --player.vida = player.vida - 1 
       -- if player.vida == 0 then 
            a:setUserData("death")
        end
    --end--]] -- RECONHECE A SE O PLAYER TOCOU COM O INIMIGO 
--[[ ESSES CALLBACKS EXERCEM A CONDIÇÃO DE MORTE DO PLAYER ]]
end
 
function endContact(a, b, coll)

end
 
function preSolve(a, b, coll)

end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end