local betatesters = {}
local betaBanner; 
local selection; 
local pointer; 

local function menu() 
	mode = require 'menu'
	mode.load() 
end

local options = {
	{['text'] = 'Return to Menu', ['action'] = menu},
	{['text'] = 'Exit Game', ['action'] = love.event.quit}
}

function betatesters.load() 
	background = love.graphics.newImage(OTHER_BG)
	betatestersBg = love.graphics.newImage(BETATEST)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = betatesters
end

function betatesters.update() 
return mode 
end

function betatesters.draw() 
	love.graphics.draw(background)
	love.graphics.draw(betatestersBg, 200,10)
	for i=1,#options do 
	if i == selection then 
		love.graphics.draw(pointer, 300, 470 + i * 20)
	end
		love.graphics.printf(options[i].text,0,470 + i * 20, love.graphics.getWidth(), 'center') 
		love.graphics.printf("Zac Giarratano - The King's School \n \n Kinari Furusawa - The King's School \n \n James Jenner - The King's School \n \n Michael Maitin Casalis- The King's School \n \n Dheeraj Raghuraman - Baulkham Hills High School \n \n Abhi Khosla - Fort Street High School",0,200,love.graphics.getWidth(), 'center')

end
end

function betatesters.keypressed(key) 
	if key == 'up' then 
		selection = (selection - 2) % (#options) + 1 
	elseif key == 'down' then 
		selection = (selection) % (#options) + 1 
	elseif key == 'return' then 
		options[selection].action() 
	end
end

return betatesters

