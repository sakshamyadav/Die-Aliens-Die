-- load variables/menu table
local menu = {} 
local selection; 
local bannerMenu;
local pointer; 
operSys = love.system.getOS() 

-- -- play function. If called by local options, require game.lua and then load the game.load function in game.lua.

local function play() 
	mode = require 'game'
	mode.load() 
end 

-- instructions function. If called by local options, require instructions.lua and then load the instructions page. 
local function instructions() 
	mode = require 'instructions'
	mode.load() 
end 

local function betatest() 
	mode = require 'betatesters'
	mode.load()
end

local function changelog() 
	mode = require 'changelog'
	mode.load()
end

local function sound()
	mode = require 'sound'
	mode.load() 
end
-- displays options that user can select from 
local options = { 
	{['text'] = 'Play', ['action'] = play},
	{['text'] = 'Instructions', ['action'] = instructions},
	{['text'] = 'Beta Testers', ['action'] = betatest},
	{['text'] = 'Changelog', ['action'] = changelog },
	{['text'] = 'Sound Options', ['action'] = sound},
	{['text'] = 'Exit Game', ['action'] = love.event.quit}

}
-- load function for menu. loads background image, banner, pointer.
function menu.load() 
	background = love.graphics.newImage(MENU_BG)
	bannerMenu = love.graphics.newImage(BANNER)
	selection = 1 
	pointer = love.graphics.newImage(POINTER)
	mode = menu 
	mac = love.graphics.newImage(MAC)
	windows = love.graphics.newImage(WINDOWS)
	linux = love.graphics.newImage(LINUX)
end 
--  returns mode variable. 
function menu.update() 
	return mode
end 
-- draw function for menu. draws background, banner, prints my personal accrediation, draws pointer.
function menu.draw()
	love.graphics.draw(background)
	love.graphics.draw(bannerMenu, 200, 10)
	love.graphics.printf("Your Operating System: "..tostring(love.system.getOS()),0, 560, love.graphics.getWidth(), 'center')
	love.graphics.printf("----- Created by Saksham Yadav ----- \n \n (Version 2.3)",0, 500,love.graphics.getWidth(), 'center')
	if operSys == "OS X" then 
		love.graphics.draw(mac, 530,510)
	end
	if operSys == "Windows" then 
		love.graphics.draw(windows,530,510)
	end
	if operSys == "Linux" then 
		love.graphics.draw(linux, 530,510)
	end
	for i=1,#options do 
		if i == selection then 
			love.graphics.draw(pointer, 300, 160 + i * 20)
		end 
		love.graphics.printf(options[i].text,-10,160 + i * 20, love.graphics.getWidth(), 'center') 
	end 
end 
-- keypressed function for menu. Controls user selection 
function menu.keypressed(key)
	if key == "up" then 
			selection = (selection - 2) % (#options) + 1 
	elseif key == "down" then 
			selection = (selection) % (#options) + 1 
	elseif key == "return" then 
			options[selection].action() 
	end 
end
-- returns menu table 
return menu 