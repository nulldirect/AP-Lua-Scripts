print('Spawned')
local crate = launchCrate(1, InternalHRP.Position+Vector3.new(0,10,0), InternalHRP.Position - Vector3.new(1, 1, 1), 0, nil, true)
local circlePlayer = true
local radius = 20
local angle = 0
local speed = 10 -- acceleration
local xv, yv, elevV = 0, 0, 0
local targetElev=40
local TargetDistance=1000
local PlayerTeam=InternalPlayer.Team
local RunService = game:GetService("RunService")
local connection
connection=RunService.Heartbeat:Connect(function(dt)
	if not crate or not crate.Parent then

		connection:Disconnect()
	end
	if circlePlayer then 
		local cenx, ceny, cenelev = InternalHRP.Position.X, InternalHRP.Position.Z, InternalHRP.Position.Y
		local pos = crate.Position
		local curx, cury, curelev = pos.X, pos.Z, pos.Y

		angle = (angle + 0.05) % (2 * math.pi)

		local tarx = cenx + math.cos(angle) * radius
		local tary = ceny + math.sin(angle) * radius

		playerDist=curelev-cenelev
		local xdist = tarx - curx
		local ydist = tary - cury
        local elevdif = targetElev - playerDist --if targetElev>floorDist then accel up
		local dist = math.sqrt(xdist * xdist + ydist * ydist)
		local accelElev = (elevdif/100) * speed
		elevV = elevV + accelElev * dt * 60
		if dist > 0 then
			local accelX = xdist / dist * speed
			local accelY = ydist / dist * speed
			xv = xv + accelX * dt * 60
			yv = yv + accelY * dt * 60
		end
	end
	local PlayerPos=InternalHRP.Position
	local ClosestPos=TargetDistance+50
	local ClosestPlayer,CurrentPos
	for Id, Player in pairs(Players:GetPlayers()) do
		if Player.Team ~= PlayerTeam then
			CurrentPos=Vector3.new(Player.Character.HumanoidRootPart.Position.X-PlayerPos.X,0,Player.Character.HumanoidRootPart.Position.Z-PlayerPos.Z).Magnitude
			if CurrentPos < ClosestPos then
				ClosestPos=CurrentPos
				ClosestPlayer=Player
			end
		end
	end
	if ClosestPlayer ~= nil then
		elevV=50*dt*60
		ClosestPos=ClosestPlayer.Character.HumanoidRootPart.Position
		circlePlayer=false
		local pos = crate.Position
		local curx, cury, curelev = pos.X, pos.Z, pos.Y
		local tarx = ClosestPos.X
		local tary = ClosestPos.Z
		local xdist = tarx - curx
		local ydist = tary - cury
		local accelX = xdist * speed
		xv = xv + accelX * dt * 60
		local accelY = ydist * speed
		yv = yv + accelY * dt * 60
		if xdist<3 and ydist<3 then
			if pos.Y<ClosestPos.Y then 
				elevV=50*dt*60*speed
			else
				elevV=-50*dt*60*speed
			end
		end
		xv,yv=xv/40*speed,yv/40*speed
	end

	local friction = 0.9 ^ (dt * 60)
	xv = xv * friction
	yv = yv * friction
    elevV = elevV * friction
	crate.BodyVelocity.Velocity = Vector3.new(xv, elevV, yv)
end)
