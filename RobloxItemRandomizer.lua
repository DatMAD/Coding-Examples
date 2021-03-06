--Roblox Item Randomizer Module Script
local module = {}

function module.GetRandomItem(itemList) --List must be the name of the item as the key, and the chance it has to be picked. Rarest item's value would be 1, most common would be math.huge or infinity.
    local randomizer = {}
    for i,v in pairs(itemList) do
        for x = 1, v do
            randomizer[#randomizer+1] = i
        end
    end
    return randomizer[math.random(1,#randomizer)]
end

function module.GetRandomVector3(maximumList) --List with the maximum/minimum x y and z
    return Vector3.new(math.random(maximumList.XMax,maximumList.XMin),math.random(maximumList.YMax,maximumList.YMin), math.random(maximumList.ZMax,maximumList.ZMin))
end

return module
