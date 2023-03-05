-- Ok here's an example of how the scripted GM commands work.
-- addgmcommand() does exactly what it says on the tin :V 
-- The first parameter is the command name, while the second param is the function it calls if the command is found.
-- It's a basic implementation but these kind of commands do have full access to the rest of the
-- scripting engine, so feel free to get creative here!

addgmcommand("scriptheal","gmcmd_heal")

function gmcmd_heal()
	percentheal(100,100)
	disp("Your HP/SP have been restored!")
end
