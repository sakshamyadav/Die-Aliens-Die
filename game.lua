
--load in the variables and tables for the game
local game = {}
local playerShip = {}
local alienUFO = {}
local alienbuls = {}
local playerbuls = {}
local playerBullets = {}
local alienBullets = {}
local aliens = {{},{},{},{},{},{},{},{},{},{},{},{}}
local health = 3
local points = 0
local level = 1
local alienMovement= true
local healthImage;
local alienQty = 0 
fps = love.timer.getFPS()
local pause = false 

local function retreat(dt) 
	if playerShip.y >= 420 then 
		playerShip.y = playerShip.y + dt * 500
	end 
	if playerShip.x < 366 then 
		playerShip.x = playerShip.x - dt * 500 
		elseif playerShip.x > 366 then 
			playerShip.x = playerShip.x + dt * 500 
		end 
	
end


-- gameover function. Goes to gameover.lua and passes the points variable to read and display to player at gameover.
local function gameOver() 
	mode = require 'gameover'
	mode.load(points) 
end 
-- gamewin function. Goes to gamewin.lua and passes the points variable to read and display to player at gamewin.
local function gameWin() 
	mode = require 'gamewin'
	mode.load(points) 
end 

--clears the tables when this function is called.
local function clearTable(t)
	for i=#t,1,-1 do
		table.remove(t,i)
	end
end
-- clears aliens to initialise game
local function clearAliens()
	for i=#aliens,1,-1 do
		for j=#aliens[i],1,-1 do
			table.remove(aliens[i], j)
		end
	end
end
--inserts aliens, their x/y position, and designates their health, according to the level. Insets enemy information in the aliens table.
local function insertAliens()
	alienQty = 0
	for i=1,5 do
		for j=1,11 do
			local enemy = {}
			enemy.x = (j-1) * alienUFO.width + 10
			enemy.y = (i-1) * alienUFO.height + 35
			if level == 2 then 
				enemy.health = love.math.random(1,2)
			end 
			if level == 3 then 
				enemy.health = love.math.random(1,4)
			end
			if level == 4 then
				enemy.health = love.math.random(1,6)
			end
			if level == 5 then
				enemy.health = love.math.random(1,8) 
			end
			if level == 6 then 
				enemy.health = love.math.random(1,10)
			end
			if level == 7 then
				enemy.health = love.math.random(1,12)
			end
			if level == 8 then
				enemy.health = love.math.random(1,14)
			end
			if level == 9 then
				enemy.health = love.math.random(1,16)
			end
			if level == 10 then 
				enemy.health = love.math.random(1,18)
			end
			if level == 11 then 
				enemy.health = love.math.random(1,20)
			end
			if level == 12 then 
				enemy.health = love.math.random(1,22)
			end 
			if level == 13 then 
				enemy.health = love.math.random(1,24)
			end
			if level == 14 then 
				enemy.health = love.math.random(1,26)
			end
			if level == 15 then 
				enemy.health = love.math.random(1,28)
			end 
			table.insert(aliens[j],enemy)
			alienQty = alienQty + 1
		end
	end
end
-- initialises the game - clears tables and inserts the aliens. Also specifices the x value of the player. 
local function initGame()
	clearTable(playerBullets)
	clearTable(alienBullets)
	clearAliens()
	insertAliens()
	playerShip.x = love.graphics.getWidth() / 2 - playerShip.width / 2
	
end


local function playerShoots()
	if not pause then 
	local bullet = {}
	bullet.x = playerShip.x + 50
	bullet.y = playerShip.y + 10
	local bullet2 = {}
	bullet2.x = playerShip.x  
	bullet2.y = playerShip.y + 10 
	table.insert(playerBullets, bullet2)
	table.insert(playerBullets, bullet)
	-- missile launch sound
	love.audio.stop(launch)
	love.audio.play(launch)
end 
end

-- function for alien shooting. Gives x and y position of the enemy's lightning bolt.

local function alienShoots(x,y)

	if not pause then 
		love.audio.stop(alienShot)
		love.audio.play(alienShot)
	local bullet = {}
	bullet.x = x + alienUFO.width/2
	bullet.y = y - 5
	table.insert(alienBullets, bullet)
end 
end

-- updates the y position of the player's bullet. If player's bullet exits the top of screen, then deduct 50 points. 
-- checks for collision with aliens. If it hits aliens, then reduce alien's health by 1, depending on level.
-- When alien health = 0, remove the alien and add 100 points for player. 
local function playerShots(dt)
	if not pause then 
--move player bullet up
	if next(playerBullets) ~= nil then
		for i= #playerBullets, 1,-1 do
			playerBullets[i].y = playerBullets[i].y - dt * playerShip.bulletSpeed
			--check for collision with top of screen and remove 50 points if missiles miss the aliens and hit screen.
			if playerBullets[i].y < 0 then
				table.remove(playerBullets,i)
				points = points - 50 
			else
				--check for collision with aliens
				for j=#aliens,1,-1 do
					for k=#aliens[j],1,-1 do
						if next(playerBullets) ~= nil and playerBullets[i] ~= nil and 
								aliens[j][k].x <= playerBullets[i].x and aliens[j][k].x + 50 >= playerBullets[i].x
								and aliens[j][k].y <= playerBullets[i].y and aliens[j][k].y + 47 >= playerBullets[i].y then
							table.remove(playerBullets, i)
							-- plays explosion sound when UFO gets hit
							love.audio.stop(UFOHit)
							love.audio.play(UFOHit)
							--checks alien health
							if level == 2 and aliens[j][k].health > 0 then 
								aliens[j][k].health = aliens[j][k].health - 1 
							elseif level == 3 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
							elseif level == 4 and aliens[j][k].health > 0 then 
								aliens[j][k].health = aliens[j][k].health - 1 
							elseif level == 5 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
							elseif level == 6 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 7 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 8 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 9 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 10 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 11 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 12 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 13 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 14 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
								elseif level == 15 and aliens[j][k].health > 0 then
								aliens[j][k].health = aliens[j][k].health - 1
							else
								--removes aliens
								table.remove(aliens[j], k)
								alienQty = alienQty - 1
								points = points + 100
							end
							break
						end
					end
				end
			end
		end
	end
end
end 
-- function for the player getting shot. Reduce health by 1 and if health = 0, call the gameover function.
local function playergetsShot()
	health = health - 1
	if health == 0 then
		love.audio.stop(loseSound)
		love.audio.play(loseSound)
		love.audio.stop(bossMusic)
		love.audio.play(bgMusic)
		gameOver() 
	end
end

-- function for aliens shooting. 
local function alienShots(dt)
	if not pause then 
	-- move alien bullets down towards player.
	if next(alienBullets) ~= nil then
		for i=#alienBullets,1, -1 do
		alienBullets[i].y = alienBullets[i].y + dt * alienUFO.bulletSpeed



	
			-- if bullets miss UFO and hit bottom of screen, remove the bullets.
			if alienBullets[i].y > love.graphics.getHeight() then
				table.remove(alienBullets,i)
				-- if player gets hit, remove alien bullets, play 'playerhit sound' and call playergetsShot function. 
			elseif playerShip.x <= alienBullets[i].x and playerShip.x + playerShip.width >= alienBullets[i].x
				and playerShip.y <= alienBullets[i].y and playerShip.y + playerShip.height >= alienBullets[i].y then
				table.remove(alienBullets, i)
				--zap sound
				love.audio.stop(playerHit)
				love.audio.play(playerHit)
				--playergetsShot function
				playergetsShot()
			end
		end
	end
end
end 


-- next level function
local function nextLvl()
	--play sound 
	--increase level by 1, add extra points based on health
	level = level + 1
	points = points + (health * 100)
	-- new alien images based on level, also increasing speed as levels progress. Call iniitialise game function for each new level.
	if level == 2 then
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY2)
		alienUFO.speed = 75
		alienUFO.bulletSpeed = 260
		alienUFO.shotProb = 6
		playerShip.bulletSpeed = 260
		playerShip.speed = 310
		initGame()
	elseif level == 3 then
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY3)
		alienUFO.speed = 100
		alienUFO.bulletSpeed = 270
		health = health + 1 
		love.audio.stop(gotHealth)
		love.audio.play(gotHealth)
		alienUFO.shotProb = 7 
		playerShip.bulletSpeed = 270
		playerShip.speed = 320
		initGame()
	elseif level == 4 then 
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY4)
		alienUFO.speed = 125 
		alienUFO.bulletSpeed = 280
		alienUFO.shotProb = 8 
		playerShip.bulletSpeed =280
		playerShip.speed = 330
		initGame()
	elseif level == 5 then 
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY5)
		alienUFO.speed = 150 
		alienUFO.bulletSpeed = 290
		alienUFO.shotProb = 9 
		playerShip.bulletSpeed =290
		playerShip.speed = 340
		initGame() 
	elseif level == 6 then 
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY6)
		alienUFO.speed = 175 
		alienUFO.bulletSpeed = 300
		health = health + 1 
		love.audio.stop(gotHealth)
		love.audio.play(gotHealth)
		alienUFO.shotProb = 10 
		playerShip.bulletSpeed = 300 
		playerShip.speed = 350
		initGame() 
	elseif level == 7 then
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY7)
		alienUFO.speed = 200 
		alienUFO.bulletSpeed = 310
		alienUFO.shotProb = 11
		playerShip.bulletSpeed = 310
		playerShip.speed = 360
		initGame() 
	elseif level == 8 then
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY8)
		alienUFO.speed = 225 
		alienUFO.bulletSpeed = 320
		alienUFO.shotProb = 12
		playerShip.bulletSpeed = 320 
		playerShip.speed = 370
		initGame() 
	elseif level == 9 then
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY9)
		alienUFO.speed = 250 
		health = health + 1 
		love.audio.stop(gotHealth)
		love.audio.play(gotHealth)
		alienUFO.bulletSpeed = 330
		alienUFO.shotProb = 13
		playerShip.bulletSpeed = 330 
		playerShip.speed = 380
		initGame() 
	elseif level == 10 then
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY10)
		alienUFO.speed = 275
		alienUFO.bulletSpeed = 340
		alienUFO.shotProb = 14
		playerShip.bulletSpeed = 340
		playerShip.speed = 390
		initGame() 
	elseif level == 11 then 
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY11)
		alienUFO.speed = 300
		alienUFO.bulletSpeed = 350
		alienUFO.shotProb = 15 
		playerShip.bulletSpeed = 350
		playerShip.speed = 400
		initGame()
	elseif level == 12 then 
		health = health + 1 
		love.audio.stop(gotHealth)
		love.audio.play(gotHealth)
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY12)
		alienUFO.speed = 325
		alienUFO.bulletSpeed = 360 
		alienUFO.shotProb = 16 
		playerShip.bulletSpeed = 360
		playerShip.speed = 410
		initGame() 
	elseif level == 13 then 
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY13)
		alienUFO.speed = 350
		alienUFO.bulletSpeed = 370 
		alienUFO.shotProb = 17
		playerShip.bulletSpeed = 370
		playerShip.speed = 420
		initGame() 
	elseif level == 14 then 
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY14)
		alienUFO.speed = 375
		alienUFO.bulletSpeed = 380 
		alienUFO.shotProb = 18
		playerShip.bulletSpeed = 380
		playerShip.speed = 430
		initGame() 
	elseif level == 15 then
		love.audio.stop(bgMusic)
		love.audio.play(bossMusic)
		health = health + 1 
		love.audio.stop(gotHealth)
		love.audio.play(gotHealth)
		alienUFO.image = love.graphics.newImage(alienUFO.ENEMY15)
		alienUFO.speed = 400
		alienUFO.bulletSpeed = 390 
		alienUFO.shotProb = 19
		playerShip.bulletSpeed = 390
		playerShip.speed = 440
		initGame() 
 
		--call gamewin function if player passes level 11
	elseif level > 15 then
		gameWin() 
		love.audio.stop(bossMusic)
		love.audio.play(bgMusic)
	love.audio.stop(winSound)
	love.audio.play(winSound)
	end
end

--game functions, can be called by several lua files to start the game, e.g. menu (play) and other files (play again).

--loads game variables, images, x/y positions, background, specifies speed, etc. 
function game.load()
	Background1 = GAME_BG.BG1
	Background2 = GAME_BG.BG2 
	Background3 = GAME_BG.BG3 
	Background4 = GAME_BG.BG4 
	Background5 = GAME_BG.BG5
	Background6 = GAME_BG.BG6 
	Background7 = GAME_BG.BG7 
	Background8 = GAME_BG.BG8 
	Background9 = GAME_BG.BG9 
	Background10 = GAME_BG.BG10 
	Background11 = GAME_BG.BG11
	Background12 = GAME_BG.BG12
	Background13 = GAME_BG.BG13
	Background14 = GAME_BG.BG14 
	Background15 = GAME_BG.BG15
	bg1 = love.graphics.newImage(Background1)
	bg2 = love.graphics.newImage(Background2)
	bg3 = love.graphics.newImage(Background3)
	bg4 = love.graphics.newImage(Background4)
	bg5 = love.graphics.newImage(Background5)
	bg6 = love.graphics.newImage(Background6)
	bg7 = love.graphics.newImage(Background7)
	bg8 = love.graphics.newImage(Background8)
	bg9 = love.graphics.newImage(Background9)
	bg10 = love.graphics.newImage(Background10)
	bg11 = love.graphics.newImage(Background11)
	bg12 = love.graphics.newImage(Background12)
	bg13 = love.graphics.newImage(Background13)
	bg14 = love.graphics.newImage(Background14)
	bg15 = love.graphics.newImage(Background15)
	level = 1
	health = 3
	points = 0
	playerShip.speed = 300
	playerShip.bulletSpeed = 250
	playerShip.width = 40
	playerShip.height = 80
	alienUFO.speed = 50
	alienUFO.width = 50
	alienUFO.height = 47
	alienUFO.ENEMY1 = ENEMY_UFO.ENEMY_1
	alienUFO.ENEMY2 = ENEMY_UFO.ENEMY_2
	alienUFO.ENEMY3 = ENEMY_UFO.ENEMY_3
	alienUFO.ENEMY4 = ENEMY_UFO.ENEMY_4
	alienUFO.ENEMY5 = ENEMY_UFO.ENEMY_5
	alienUFO.ENEMY6 = ENEMY_UFO.ENEMY_6
	alienUFO.ENEMY7 = ENEMY_UFO.ENEMY_7
	alienUFO.ENEMY8 = ENEMY_UFO.ENEMY_8
	alienUFO.ENEMY9 = ENEMY_UFO.ENEMY_9
	alienUFO.ENEMY10 = ENEMY_UFO.ENEMY_10
	alienUFO.ENEMY11 = ENEMY_UFO.ENEMY_11
	alienUFO.ENEMY12 = ENEMY_UFO.ENEMY_12
	alienUFO.ENEMY13 = ENEMY_UFO.ENEMY_13
	alienUFO.ENEMY14 = ENEMY_UFO.ENEMY_14
	alienUFO.ENEMY15 = ENEMY_UFO.ENEMY_15 
	alienUFO.shotProb = 5 
	alienUFO.bulletSpeed = 250
	alienUFO.image = love.graphics.newImage(alienUFO.ENEMY1)
	playerShip.IMAGE = PLAYER_IMG
	playerShip.image = love.graphics.newImage(playerShip.IMAGE)
	healthImage = love.graphics.newImage(HEALTH_IMG)
	playerShip.x = love.graphics.getWidth() / 2 - playerShip.width/2
	playerShip.y = love.graphics.getHeight() - 100
	alienbuls.image = love.graphics.newImage(ENEMY_BULLET)
	playerbuls.image = love.graphics.newImage(PLAYER_BULLET)
	initGame()
end

-- draw function. draws the background, alien and player bullets, points, health, aliens, player.
function game.draw()
	if level == 1 then 
		love.graphics.draw(bg1)
	end
	if level == 2 then 
		love.graphics.draw(bg2)
	end 
	if level == 3 then 
		love.graphics.draw(bg3)
	end
	if level == 4 then 
		love.graphics.draw(bg4)
	end
	if level == 5 then 
		love.graphics.draw(bg5)
	end 
	if level == 6 then 
		love.graphics.draw(bg6)
	end
	if level == 7 then 
		love.graphics.draw(bg7)
	end
	if level == 8 then 
		love.graphics.draw(bg8)
	end
	if level == 9 then 
		love.graphics.draw(bg9)
	end
	if level == 10 then 
		love.graphics.draw(bg10)
	end
	if level == 11 then 
		love.graphics.draw(bg11)
	end
	if level == 12 then
		love.graphics.draw(bg12)
	end
	if level == 13 then 
		love.graphics.draw(bg13)
	end
	if level == 14 then 
		love.graphics.draw(bg14)
	end
	if level == 15 then 
		love.graphics.draw(bg15)
	end 
	if next(playerBullets) ~= nil then
		for i=1,#playerBullets do
			love.graphics.draw(playerbuls.image, playerBullets[i].x, playerBullets[i].y)
		end
	end
	if next(alienBullets) ~= nil then
		for i=1,#alienBullets do
			love.graphics.draw(alienbuls.image, alienBullets[i].x, alienBullets[i].y)
		end
	end
	if next(aliens) ~= nil then
		for i=1,#aliens do
			for j=1,#aliens[i] do
				love.graphics.draw(alienUFO.image, aliens[i][j].x, aliens[i][j].y)
			end
		end
	end
	if pause then 
	love.graphics.print("GAME PAUSED - RETURN TO MENU? (Y/N)", love.graphics.getWidth() - 500, 15)
end
if not pause then 
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), love.graphics.getWidth() - 150, 15 )
	love.graphics.print('Level: '..level, love.graphics.getWidth() - 460, 15)
	love.graphics.print('Points: '..points, love.graphics.getWidth() - 300, 15)
	love.graphics.print('Lives: ', 150, 15)
end 
	love.graphics.draw(playerShip.image, playerShip.x, playerShip.y)
	if not pause then 
	for i=1,health do
		love.graphics.draw(healthImage, 170 + i * 15 , 15)
	end
end 
end 
	-- update function. Does all the math and updates the game based on player inputs and the program itself.
	-- responsible for updating player's left and right movements based on keydown
function game.update(dt)

	if not pause then 
		if alienQty == 0 then
			nextLvl()
		end
		
		if love.keyboard.isDown("right") then
			playerShip.x = playerShip.x + dt * playerShip.speed
		end
		if love.keyboard.isDown("left") then
			playerShip.x = playerShip.x - dt * playerShip.speed
		end
		if love.keyboard.isDown("up") then 
				playerShip.y = playerShip.y - dt * playerShip.speed 
		end
		if love.keyboard.isDown("down") then 
				playerShip.y = playerShip.y + dt * playerShip.speed
		end
		if love.keyboard.isDown("lshift") then 
			retreat(dt)
		end 
		--update playerShots(dt) and alienShots(dt) functions.
		playerShots(dt)
		alienShots(dt)
		-- determines probability of enemy shooting lightning down. generates a random number from 1 to 100 and compares to see if it is less than 5.
		-- if it is less than 5, then compare a random number from 1 to (number of aliens) and then call alienShoots function.
		if love.math.random(1,100) < alienUFO.shotProb then
			local r = love.math.random(1,#aliens)
			if next(aliens[r]) ~= nil then
				alienShoots(aliens[r][#aliens[r]].x,aliens[r][#aliens[r]].y)
			end
		end
		--responsible for left and right movement of aliens. Checks boolean variable alienMovement. If true, then move aliens right. Then change it to false.
		if alienMovement then
			for i=1,#aliens do
				for j=1,#aliens[i] do
					aliens[i][j].x = aliens[i][j].x + dt * alienUFO.speed
					if aliens[i][j].x + alienUFO.width + 2 >= love.graphics.getWidth() then
						alienMovement = false
					end
				end
			end
		else
			--now, if alienMovement is false, then move the aliens left, then change alienMovement back to true. 
			for i=1,#aliens do
				for j=1,#aliens[i] do
					aliens[i][j].x = aliens[i][j].x - dt * alienUFO.speed
					if aliens[i][j].x - 2 <= 0 then
						alienMovement = true
					end
				end
			end
		end
		if playerShip.y < 420 then
			playerShip.y = 420 
			elseif playerShip.y > 500 then 
				playerShip.y = 500 
			end 
	-- if player's x position is < 0 or > screen's width - 68 (player's spaceship width), stop the player from moving further (screen barrier). 
		if playerShip.x < 0 then
			playerShip.x = 0
		elseif playerShip.x > love.graphics.getWidth() - 68 then
			playerShip.x = love.graphics.getWidth() - 68
		end
	end 
end 
	-- keypressed function for player's shots. If spacebar is pressed, call the playerShoots() function.
	-- this wasn't put in game.update(dt)/keyboard.isDown to prevent the player from holding the spacebar to rapid fire.
function game.keypressed(key)
	if key == " " then 
		playerShoots()
	end
	if key == "p" then 
		pause = not pause 
	end 
	if pause then 
		if key == "y" then 
		mode = require 'menu'
		mode.load() 
		pause = not pause 

	else if key == "n" then 
		pause = not pause 
	end 

end 
end 
end 
 
	
-- return the game table to the lua files that call it.

return game