isDaytime = function(timeOfDay)
	local timeOfDay = getGameTime():getTimeOfDay();
	local dawn = getClimateManager():getSeason():getDawn()
	local dusk = getClimateManager():getSeason():getDusk()
	if (timeOfDay >= dawn) and (timeOfDay <= dusk) then
		return true
	else
		return false
	end
end
--This seems like it should do exactly what the DAYORNIGHT function did in the original, other than changing > < to >= and <=. But for whatever reason, the DAYORNIGHT
--did not seem to work properly. Day never ended until late at night (2200 or later), even in seasons other than summer. And dawn seemed to happen at 0500 or so in every
--season. This method seems to work properly, for reasons unknown to me.


local function TraitSunlightSensitive()
    local player = getPlayer();
	local fog = getClimateManager():getFogIntensity(); --gets fog levels, from 0 to 1
	local clouds = getClimateManager():getCloudIntensity(); --gets cloud levels, from 0 to 1
	local precip = getClimateManager():getPrecipitationIntensity(); --anything other than 0 is some form of rain/snow
	local cover = math.max(fog,clouds); --takes the value for fog or cloud levels, whichever is higher
	if isDaytime(timeOfDay) and player:getVehicle() then
        local allBodyParts = player:getBodyDamage():getBodyParts()
        local bodyPart = allBodyParts:get(ZombRand(allBodyParts:size()))
        bodyPart:AddDamage(0) --prevents daytime damage in vehicles
    elseif isDaytime(timeOfDay) and player:isOutside() and precip == 0 then --negates sun damage if it is raining/snowing
        local allBodyParts = player:getBodyDamage():getBodyParts()
        local bodyPart = allBodyParts:get(ZombRand(allBodyParts:size()))
		bodyPart:AddDamage((1-cover)*5) --subtracts the total cloudiness/fogginess from 1, results in sun damage being reduced/elimated based on total amount of cloud/fog cover
    end
end

local function TraitMinorSunlightSensitivity()
   local player = getPlayer();
	local fog = getClimateManager():getFogIntensity();
	local clouds = getClimateManager():getCloudIntensity();
	local precip = getClimateManager():getPrecipitationIntensity();
	local cover = math.max(fog,clouds);
    if isDaytime(timeOfDay) and player:getVehicle() then
        local allBodyParts = player:getBodyDamage():getBodyParts()
        local bodyPart = allBodyParts:get(ZombRand(allBodyParts:size()))
        bodyPart:AddDamage(0)
    elseif isDaytime(timeOfDay) and player:isOutside() and precip == 0 then
        local allBodyParts = player:getBodyDamage():getBodyParts()
        local bodyPart = allBodyParts:get(ZombRand(allBodyParts:size()))
	    bodyPart:AddDamage((1-cover)*1)
    end
end

local function TraitExtremeSunlightSensitivity()
   local player = getPlayer();
   local timeOfDay = getGameTime():getTimeOfDay();
	local fog = getClimateManager():getFogIntensity();
	local clouds = getClimateManager():getCloudIntensity();
	local precip = getClimateManager():getPrecipitationIntensity();
	local cover = math.max(fog,clouds);
    if isDaytime(timeOfDay) and player:getVehicle() then
        local allBodyParts = player:getBodyDamage():getBodyParts()
        local bodyPart = allBodyParts:get(ZombRand(allBodyParts:size()))
        bodyPart:AddDamage(0)
    elseif isDaytime(timeOfDay) and player:isOutside() and precip == 0 then
        local allBodyParts = player:getBodyDamage():getBodyParts()
        local bodyPart = allBodyParts:get(ZombRand(allBodyParts:size()))
	    bodyPart:AddDamage((1-cover)*10)
    end
end

local function AddTraitEffects(_index, player)
    Events.EveryOneMinute.Remove(TraitSunlightSensitive)
    Events.EveryOneMinute.Remove(TraitMinorSunlightSensitivity)
    Events.EveryOneMinute.Remove(TraitExtremeSunlightSensitivity)

    if player:HasTrait('sunlightsensitive') then
        Events.EveryOneMinute.Add(TraitSunlightSensitive)
    end

    if player:HasTrait('minorsunlightsensitivity') then
        Events.EveryOneMinute.Add(TraitMinorSunlightSensitivity)
    end

    if player:HasTrait('extremesunlightsensitivity') then
        Events.EveryOneMinute.Add(TraitExtremeSunlightSensitivity)
    end
end
Events.OnCreatePlayer.Add(AddTraitEffects)
