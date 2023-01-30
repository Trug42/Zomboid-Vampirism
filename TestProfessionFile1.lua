local DoProfessions = function()
  --    variable                                  name       text                        icon                  free trait points
	local vampireFledgling = ProfessionFactory.addProfession("Vampire Fledgling", getText("Vampire Fledgling"), "profession_vampire", 0);

  vampireFledgling:addXPBoost(Perks.Agility, 3)
  vampireFledgling:addXPBoost(Perks.Fitness, 3)
  vampireFledgling:addXPBoost(Perks.Sprinting, 3)
  vampireFledgling:addXPBoost(Perks.Strength, 3)
  vampireFledgling:addFreeTrait("minorsunlightsensitivity")
  
  local vampire = ProfessionFactory.addProfession("Vampire", getText("Vampire"), "profession_vampire", 0);

  vampire:addXPBoost(Perks.Agility, 5)
  vampire:addXPBoost(Perks.Fitness, 5)
  vampire:addXPBoost(Perks.Sprinting, 5)
  vampire:addXPBoost(Perks.Strength, 5)
  vampire:addFreeTrait("sunlightsensitive")
  
  local vampireElder = ProfessionFactory.addProfession("Elder Vampire", getText("Elder Vampire"), "profession_vampire", 0);

  vampireElder:addXPBoost(Perks.Agility, 10)
  vampireElder:addXPBoost(Perks.Fitness, 10)
  vampireElder:addXPBoost(Perks.Sprinting, 10)
  vampireElder:addXPBoost(Perks.Strength, 10)
  vampireElder:addFreeTrait("extremesunlightsensitivity")
  
  
end

-- https://pzwiki.net/wiki/Modding:Lua_Event
Events.OnGameBoot.Add(DoProfessions);
