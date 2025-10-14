local elev=2000 --How high the crates spawn
local xlen,zlen=200,200 --The amount of spread possible for each crate
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local hitPosition,hitInstance
local connection
local go=false
local part = Instance.new("Part")
part.Shape='Cylinder'
part.Size = Vector3.new(1000, 100, 100)
part.Position = Vector3.new(0, 3000, 0)
part.Anchored = true
part.Material='Glass'
part.CanCollide=false
part.Transparency=0.5
part.Parent = workspace
local END =false
connection=UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end 
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.LeftBracket then
            END = true
        end
        if input.KeyCode == Enum.KeyCode.Quote and not go then
            local wingmanClRequire = shared.clRequire
            local wingmanClibUtil = wingmanClRequire("clibUtil")
            local utlMouseTargetFiltered = wingmanClibUtil.utlMouseTargetFiltered
            hitPosition, hitInstance = utlMouseTargetFiltered()
            go = true
        end
    end


end)
local function beacon(xpos,ypos,zpos)
    part.CFrame=CFrame.new(xpos,ypos,zpos)*CFrame.Angles(math.rad(45),math.rad(90),math.rad(45))
end
local function crate(xpos,ypos,zpos,yvel,fuse)
    spawnCrate(1,Vector3.new(xpos,ypos,zpos),Vector3.new(0,yvel,0),fuse)
    task.wait(0.1)
end
local function fuseTime(ydist,yvel,fuse)
    local fuse1,fuse2
    fuse1 = ((yvel*-1) + math.sqrt((yvel)^2 - 4 * (-98.1) * (math.abs(ydist)))) / (2*-98.1)
    fuse2 = ((yvel*-1) - math.sqrt((yvel)^2 - 4 * (-98.1) * (math.abs(ydist)))) / (2*-98.1)
    if fuse1 > 0 and fuse2 > 0 then
        fuse = math.min(fuse1, fuse2)
    elseif fuse1 > 0 then
        fuse = fuse1
    elseif fuse2 > 0 then
        fuse = fuse2
    end
    return fuse
end
local var = 5
while not END do
    crates=50 --How many crates it spawns
    var=5 --How many times it tries to raycast before giving up
    rayresu=nil
    while not go and not END do --Wait until user targeted somewhere
        task.wait(1)
    end
    local xcenter,zcenter=hitPosition.X,hitPosition.Z
    beacon(xcenter,hitPosition.Y,zcenter) --Teleport local cylinder
    local minxbound,maxxbound=xcenter-xlen/2,xcenter+xlen/2
    local minzbound,maxzbound=zcenter-zlen/2,zcenter+zlen/2
    local x,z,origin,rayDest,raydire,rayresu=0,0,0,0,0,nil
    local yvel=-1000 --How much downwards velocity each crate has
    local fuse --How long until each crate explodes
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {part} -- ignore beacon
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    while crates>0 do
        if END then
            break
        end
        minxbound,maxxbound=xcenter-xlen/2,xcenter+xlen/2
        minzbound,maxzbound=zcenter-zlen/2,zcenter+zlen/2
        x,z=math.random(minxbound,maxxbound),math.random(minzbound,maxzbound)
       
        while rayresu==nil and var >0 do
            origin=Vector3.new(x,elev,z)
            rayDest = Vector3.new(x,0,z)
            raydire=rayDest-origin
            rayresu = workspace:Raycast(origin, raydire,raycastParams)
            var=var -1
        end
        if rayresu==nil then
            origin=Vector3.new(0,300,0)
            rayDest = Vector3.new(0,0,0)
            raydire=rayDest-origin
            rayresu = workspace:Raycast(origin, raydire,raycastParams)
        end
        --xcenter,zcenter=InternalHRP.Position.X,InternalHRP.Position.Z
        beacon(xcenter,InternalHRP.Position.Y,zcenter)
        --print(rayresu.Instance.Anchored)
        --print(x,elev,z)
        fuse = fuseTime(rayresu.Distance,yvel,fuse)
        crate(x,elev,z,yvel,fuse)
        task.wait(0.2)




       
        crates=crates-1
    end
    print('Worked?\n\n\n')
    go=false
    task.wait(0.15)
end
part:destroy()
--This is as much comments as you’ll get from me

