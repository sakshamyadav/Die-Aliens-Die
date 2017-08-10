local sound = {}
local soundBanner;
local pointer; 
local selection; 
local sfx = true 
local music = true 

local function menu() 
	mode = require 'menu'
	mode.load()
end

local function muteMusic() 
	if music then 
	toggleOff:stop()
	toggleOff:play()
	bgMusic:setVolume(0)
	bossMusic:setVolume(0)
	music = false 
else 
	music = true
	toggleOn:stop()
	toggleOn:play()
	bgMusic:setVolume(1)
	bossMusic:setVolume(1)
end
end

local function muteSFX()
	if sfx then 
		toggleOff:stop()
		toggleOff:play()
	launch:setVolume(0)
	UFOHit:setVolume(0)
	alienShot:setVolume(0)
	playerHit:setVolume(0)
	gotHealth:setVolume(0)
	winSound:setVolume(0)
	loseSound:setVolume(0)
	sfx = false
else
	 sfx = true 
	 toggleOn:stop()
	 toggleOn:play() 
	launch:setVolume(0.3)
	UFOHit:setVolume(0.3)
	alienShot:setVolume(0.5)
	playerHit:setVolume(1)
	gotHealth:setVolume(1)
	winSound:setVolume(1)
	loseSound:setVolume(1)
end 
end 


local options = {
	{['text'] = 'Mute Music', ['action'] = muteMusic},
	{['text'] = 'Mute Sound', ['action'] = muteSFX},
	{['text'] = 'Return to Menu', ['action'] = menu}
}

function sound.load() 
	background = love.graphics.newImage(OTHER_BG)
	soundBanner = love.graphics.newImage(SOUND)
	selection =1  
	pointer = love.graphics.newImage(POINTER)
	mode = sound 
	vol = love.graphics.newImage(VOL)
	mute = love.graphics.newImage(MUTE)
end

function sound.update()
	return mode 
end

function sound.draw() 
	love.graphics.draw(background)
	love.graphics.draw(soundBanner, 200,10)
	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 300, 470 + i * 20)
		end 
		love.graphics.printf(options[i].text,0,470 + i * 20, love.graphics.getWidth(), 'center')
	end
	if music then 
		love.graphics.printf("Music: ON", 0,200, love.graphics.getWidth(), 'center')
		love.graphics.draw(vol,450 ,197)
	else 
		love.graphics.printf("Music: OFF", 0,200, love.graphics.getWidth(), 'center')
		love.graphics.draw(mute, 450, 197)
	end

	if sfx then 
		love.graphics.printf("Sound Effects: ON", 0 , 250, love.graphics.getWidth(), 'center')
		love.graphics.draw(vol, 475, 247)
	else
		love.graphics.printf("Sound Effects: OFF", 0, 250, love.graphics.getWidth(), 'center')
		love.graphics.draw(mute, 475, 247)
	end


end

function sound.keypressed(key)
	if key == 'up' then 
		selection = (selection - 2) % (#options) + 1 
	elseif key == 'down' then 
		selection = (selection) % (#options) + 1 
	elseif key == 'return' then 
		options[selection].action() 
	end
end

return sound 


