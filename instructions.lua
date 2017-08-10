-- declare local variables for instructions. Create instructions table

local instructions = {}
local instructionsBanner;
local selection;
local pointer; 

-- menu function. If called by local options, require menu.lua and then load the menu.load function in menu.lua

local function menu() 
	mode = require 'menu'
	mode.load() 
end 
-- play function. If called by local options, require game.lua and then load the game.load function in game.lua.

local function play() 
	mode = require 'game'
	mode.load() 
end 
-- display the options that the user can select from. 

local options = {
	{['text'] = 'Play', ['action'] = play},
	{['text'] = 'Return to Menu', ['action'] = menu},
	{['text'] = 'Exit Game', ['action'] = love.event.quit}
}

-- load function for instructions. loads background, banner, pointer. Can be called by the .load function from other lua files. 
function instructions.load() 
background = love.graphics.newImage(OTHER_BG)
keyboard = love.graphics.newImage(KEYBOARD)
instructionsBanner = love.graphics.newImage(INSTRUCTIONS)
selection = 1 
pointer = love.graphics.newImage(POINTER)
mode = instructions
end 
-- returns mode variable
function instructions.update()
	return mode 
end 
-- draw function for instructions. draws relevent images and text. 
function instructions.draw() 
	love.graphics.draw(background)
	love.graphics.draw(keyboard, 200,210)
	love.graphics.draw(instructionsBanner, 200,10)
		for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 300, 470 + i * 20)
		end 
		love.graphics.printf(options[i].text,0,470 + i * 20, love.graphics.getWidth(), 'center') 
		love.graphics.printf("You must clear all 11 levels to win the game. \n \n 100 points will be awarded for each alien killed and 50 deducted for each shot you miss. \n \n  You start with three lives and gain one extra every 3 levels. \n \n Bonus points are awarded at the end of each level (100 x number of lives remaining)",0, 335, love.graphics.getWidth(),  'center')
	end
end 
-- keypressed function for instructions. Controls user input for selecting options 
function instructions.keypressed(key)
	if key == 'up' then 
		selection = (selection - 2) % (#options) + 1 
	elseif key == 'down' then 
		selection = (selection) % (#options) + 1 
	elseif key == 'return' then 
		options[selection].action() 
	end
end
-- return instructions table 
return instructions