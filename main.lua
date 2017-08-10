-- require the config.lua file
require 'conf'

-- load in all images
PLAYER_BULLET = 'Images/playerbullet.png'
ENEMY_BULLET = 'Images/enemybullet.png'
HEALTH_IMG = 'Images/life.png'
ENEMY_UFO = { 

ENEMY_1 = 'Images/enemy1.png',
ENEMY_2 = 'Images/enemy2.png',
ENEMY_3 = 'Images/enemy3.png',
ENEMY_4 = 'Images/enemy4.png',
ENEMY_5 = 'Images/enemy5.png',
ENEMY_6 = 'Images/enemy6.png',
ENEMY_7 = 'Images/enemy7.png',
ENEMY_8 = 'Images/enemy8.png',
ENEMY_9 = 'Images/enemy9.png',
ENEMY_10 = 'Images/enemy10.png',
ENEMY_11 = 'Images/enemy11.png',
ENEMY_12 = 'Images/enemy12.png',
ENEMY_13 = 'Images/enemy13.png',
ENEMY_14 = 'Images/enemy14.png',
ENEMY_15 = 'Images/enemy15.png'
}

GAME_BG = {
BG1 = 'Images/bglvl1.png',
BG2 = 'Images/bglvl2.png',
BG3 = 'Images/bglvl3.png',
BG4 = 'Images/bglvl4.png',
BG5 = 'Images/bglvl5.jpg',
BG6 = 'Images/bglvl6.jpg',
BG7 = 'Images/bglvl7.jpg',
BG8 = 'Images/bglvl8.jpg',
BG9 = 'Images/bglvl9.jpg',
BG10 = 'Images/bglvl10.jpg',
BG11 = 'Images/bglvl11.jpg',
BG12 = 'Images/bglvl12.jpg',
BG13 = 'Images/bglvl13.jpg',
BG14 = 'Images/bglvl14.jpg',
BG15 = 'Images/bglvl15.jpg'

}
CHANGELOG = 'Images/changelog.png'
PLAYER_IMG = 'Images/spaceship.png'
YOU_WIN = 'Images/win.png'
BANNER = 'Images/menubanner.png' 
INVASION = 'Images/invasion.jpg'
DONE = 'Images/finished.png'
POINTER = 'Images/pointer.png'
INSTRUCTIONS = 'Images/instructions.png'
YOU_LOSE = 'Images/lose.png'
MENU_BG = 'Images/menubg.jpg'
OTHER_BG = 'Images/other_bg.png'
KEYBOARD = 'Images/keyboard.png'
BETATEST = 'Images/betatest.png'
SOUND = 'Images/sound.png'
VOL = 'Images/vol.png'
MUTE = 'Images/volmute.png'
HIT = 'Images/elec.png'
MAC = 'Images/mac.png'
WINDOWS = 'Images/windows.png'
LINUX = 'Images/linux.png'
MENUBOX = 'Images/menubox.png'

-- load in all sound 
launch = love.audio.newSource("Sound/launch.mp3")
UFOHit = love.audio.newSource("Sound/ufogethit.mp3")
playerHit = love.audio.newSource("Sound/gethit.mp3")
gotHealth = love.audio.newSource("Sound/nextlvl.mp3")
bgMusic = love.audio.newSource("Sound/bgmusic.mp3")
winSound = love.audio.newSource("Sound/win.wav")
toggleOn = love.audio.newSource("Sound/toggleon.mp3")
toggleOff = love.audio.newSource("Sound/toggleoff.mp3")
loseSound = love.audio.newSource("Sound/lose.wav")
bossMusic = love.audio.newSource("Sound/bossmusic.mp3")
alienShot = love.audio.newSource("Sound/alienshot.mp3")
-- set loop for background music
bgMusic:play()
bgMusic:setLooping(true)
-- set volume 
bgMusic:setVolume(1)
launch:setVolume(0.3)
alienShot:setVolume(0.5)
UFOHit:setVolume(0.3)
playerHit:setVolume(1)
gotHealth:setVolume(1)
winSound:setVolume(1)
loseSound:setVolume(1)
bossMusic:setVolume(1)

-- load function to call menu.load() from menu.lua 
function love.load() 
	mode = require "menu"
	mode.load() 
end 
-- draw function for images
function love.draw()
	mode.draw()
end 
-- keypressed function to control user inputs
function love.keypressed(key, isrepeat) 
	mode.keypressed(key)
end
-- update function (delta time) to update variables/perform mathematical calculations.
function love.update(dt)
	mode.update(dt)
end 