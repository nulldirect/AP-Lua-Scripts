local UserInputService = game:GetService("UserInputService")
local hitPosition,hitInstance
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- ignore inputs typed in chat/textboxes
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Quote then
            local wingmanClRequire = shared.clRequire
            local wingmanClibUtil = wingmanClRequire("clibUtil")
            local utlMouseTargetFiltered = wingmanClibUtil.utlMouseTargetFiltered
            hitPosition, hitInstance = utlMouseTargetFiltered()
			InternalHRP.Position=hitPosition+Vector3.new(0,100,0)
            
        end
    end

end)

local wingmanClRequire = shared.clRequire
local wingmanClibUtil = wingmanClRequire("clibUtil")
local utlMouseTargetFiltered = wingmanClibUtil.utlMouseTargetFiltered
hitPosition, hitInstance = utlMouseTargetFiltered()
InternalHRP.Position=hitPosition+Vector3.new(0,100,0)
