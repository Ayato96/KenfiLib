PlayerLib = {
	getTown = function(self)
		return getPlayerTown(self.id)
	end,
	getDescription = function(self)
		return ("%s. %s"):format(getPlayerNameDescription(self.id), getPlayerSpecialDescription(self.id))
	end,
	getLevel = function(self) return getPlayerLevel(self.id) end,
	getGuid = function(self) return getPlayerGUID(self.id) end,
	getIp = function(self) return getPlayerIp(self.id) end,
	getAccountId = function(self) return getAccountIdByName(getPlayerAccount(self.id)) end,
	addItem = function(self, item, count)
		local item = doPlayerAddItem(self.id, item, count or 1)
		if isContainer(item) then
			return Container(item)
		else
			return Item(item)
		end
	end,
	sendChannelMessage = function(self, author, message, type, channel)
		if type >= 18 then
			self:sendTextMessage(type, message)
			return
		end
		doPlayerSendChannelMessage(self.id, author, message, type, channel)
	end,
	sendTextMessage = function(self, type, message, channel)
		if type < 18 or channel then
			self:sendChannelMessage(self:getName(), message, type, channel)
			return
		end
		doPlayerSendTextMessage(self.id, type, message)
	end,
	getMana = function(self) return getCreatureMana(self.id) end,
	getMaxMana = function(self) return getCreatureMaxMana(self.id) end,
	getLastLoginSaved = function(self)
		return getPlayerLastLogin(self.id)
	end,
	getAccountManager = function(self)
		return getPlayerAccountManager(self.id)
	end,
	getFreeCapacity = function(self)
		return getPlayerFreeCap(self.id)
	end,
	getDepotItems = function(self, depotId)
		return getPlayerDepotItems(self.id, depotId)
	end,
	getSkullTime = function(self)
		return getPlayerSkullEnd(self.id)
	end,
	setSkullTime = function(self, skullTime, skullType)
		return doPlayerSetSkullEnd(self.id, skullTime, skullType or self:getSkull())
	end,
	getExperience = function(self)
		return getPlayerExperience(self.id)
	end,
	addExperience = function(self, amount)
		doPlayerAddExperience(cid, math.abs(amount))
	end,
	removeExperience = function(self, amount)
		doPlayerAddExperience(cid, -(math.abs(amount)))
	end,
	getMagicLevel = function(self)
		return getPlayerMagLevel(self.id)
	end,
	getBaseMagicLevel = function(self)
		return getPlayerMagLevel(self.id, true)
	end,
	getManaSpent = function(self)
		return getPlayerSpentMana(self.id)
	end,
	addManaSpent = function(self, amount)
		doPlayerAddSpentMana(self.id, amount, true)
	end,
	getBaseMaxHealth = function(self)
		return getCreatureMaxHealth(self.id, true)
	end,
	getBaseMaxMana = function(self)
		return getCreatureMaxMana(self.id, true)
	end,
}

function Player(uid)
	if tonumber(uid) and isPlayer(uid) then
		return setmetatable({id = uid}, {__index = setmetatable(PlayerLib, {__index = CreatureLib}), __eq = eq_event(a, b)})
	elseif getmetatable(uid) then
		return setmetatable({id = uid:getId()}, {__index = setmetatable(PlayerLib, {__index = CreatureLib}), __eq = eq_event(a, b)})
	elseif getPlayerByName(uid) then
		return setmetatable({id = getPlayerByName(uid)}, {__index = setmetatable(PlayerLib, {__index = CreatureLib}), __eq = eq_event(a, b)})
	end
end
