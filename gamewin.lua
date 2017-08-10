-- create gamwin table and declare variables

local gamewin = {}
local gamewinBANNER; 
local selection; 
local pointer; 
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
{['text'] = 'Return to Menu', ['action'] = menu},
{['text'] = 'Exit Game', ['action'] = love.event.quit}
}
 
-- get the points variable from game.lua and display the score to player here. Also responsible for loading background, banner, and pointer image.

function gamewin.load(scorefromGame) 
	background = love.graphics.newImage(DONE)
	points = scorefromGame
	gamewinBANNER = love.graphics.newImage(YOU_WIN)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = gamewin 
end 
-- update function for gamewin. Returns variable mode. 

function gamewin.update() 
	return mode
end 
-- draw function for gamewin. Draws the background, gamewin banner and displays message to user.

function gamewin.draw() 
	love.graphics.draw(background)
	if points < 0 then 
	love.graphics.printf("Negative points? Really?...", -50, 180,love.graphics.getWidth(), 'center')
	else
	love.graphics.printf("You won with a score of "..points.." points, well done!", -30, 180, love.graphics.getWidth(), 'center')
end 
	love.graphics.draw(gamewinBANNER, 200, 10)
	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 300, 350 + i * 20)
		end 
		love.graphics.printf(options[i].text,0,350 + i * 20, love.graphics.getWidth(), 'center') 
	end 
end 

-- keypressed function for gamewin. Controls user input for selecting optins. 

function gamewin.keypressed(key)
	if key == "up" then 
			selection = (selection - 2) % (#options) + 1 
	elseif key == "down" then 
			selection = (selection) % (#options) + 1 
	elseif key == "return" then 
			options[selection].action() 
	end 
end
-- return gamewin table
return gamewin 