-- create gameover table and declare variables
local gameover = {}
local gameoverBANNER; 
local pointer; 
local selection; 
local points; 

-- play function. If called by local options, require game.lua and then load the game.load function in game.lua.
local function play() 
	mode = require 'game'
	mode.load()
end

-- menu function. If called by local options, require menu.lua and then load the menu.load function in menu.lua
local function menu() 
	mode = require 'menu'
	mode.load() 
end 

-- display the options that the user can select from. 
local options = { 
	{['text'] = 'Play Again', ['action'] = play},
	{['text'] = 'Return to menu', ['action'] = menu},
	{['text'] = 'Exit Game', ['action'] = love.event.quit}

}

-- get the points variable from game.lua and display the score to player here. Also responsible for loading background, banner, and pointer image.
function gameover.load(scorefromGame) 
	background = love.graphics.newImage(INVASION)
	points = scorefromGame
	gameoverBANNER = love.graphics.newImage(YOU_LOSE)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = gameover
end 

-- update function for gameover. Returns variable mode. 
function gameover.update()
	return mode 
end 
-- draw function for gameover. Draws the background, gameover banner and displays message to user.
function gameover.draw() 
	love.graphics.draw(background)
	love.graphics.printf("You ran out of lives and finished with a score of " ..points .." points", 0,220,love.graphics.getWidth(), 'center')
	love.graphics.draw(gameoverBANNER, 200, 10)
	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 300, 250 + i * 20)
		end 
		love.graphics.printf(options[i].text,0,250 + i * 20, love.graphics.getWidth(), 'center') 
	end 
end 

-- keypressed function for gameover. Controls user input for selecting optins. 

function gameover.keypressed(key)
	if key == "up" then 
			selection = (selection - 2) % (#options) + 1 
	elseif key == "down" then 
			selection = (selection) % (#options) + 1 
	elseif key == "return" then 
			options[selection].action() 
	end 
end
-- return gameover table
return gameover 
