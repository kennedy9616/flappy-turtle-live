
function beginContact(a, b, coll)

    if a:getUserData()=="player" and b:getUserData()=="inimigo" then
        --player.vida = player.vida - 1 
        --if player.vida == 0 then 
            a:setUserData("morto")
        --end
    end--]] -- RECONHECE A SE O PLAYER TOCOU COM O INIMIGO 

end
 
function endContact(a, b, coll)

end
 
function preSolve(a, b, coll)

end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end