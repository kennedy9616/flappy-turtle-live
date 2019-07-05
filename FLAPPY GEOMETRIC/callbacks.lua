
function beginContact(a, b, coll)
    if a:getUserData()=="player" and b:getUserData()=="inimigo" then
        a:setUserData("morto")
    end--]] -- RECONHECE A SE O PLAYER TOCOU COM O INIMIGO 

end
 
function endContact(a, b, coll)

end
 
function preSolve(a, b, coll)

end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end