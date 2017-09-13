local UserInfoPlaneOperator = class("UserInfoPlaneOperator")

local CHILD_NAME_PORTRAIT = "portrait"
local CHILD_NAME_NICK = "nick_lb"
local CHILD_NAME_COINS = "coins_lb"
local CHILD_NAME_ZHUANG_SIGNAL = "zhuang_signal"
local CHILD_NAME_NETWORK_IMG = "network_img"

function UserInfoPlaneOperator:init(plane)
	plane:setVisible(false)

	local zhuang_signal = plane:getChildByName(CHILD_NAME_ZHUANG_SIGNAL)

	zhuang_signal:setVisible(false)
end

function UserInfoPlaneOperator:clearGameDatas(plane)
	local zhuang_signal = plane:getChildByName(CHILD_NAME_ZHUANG_SIGNAL)

	zhuang_signal:setVisible(false)
end

function UserInfoPlaneOperator:showInfo(userInfo, plane)
	if not plane then
		--todo
		return
	end

	plane:setVisible(true)

	local photoUrl = userInfo["photoUrl"]
	local nickname = userInfo["nick"]
	-- local coins = userInfo["coins"] - 20000
	local coins = userInfo["coins"]

	local portrait = plane:getChildByName(CHILD_NAME_PORTRAIT)
	local nick_lb = plane:getChildByName(CHILD_NAME_NICK)
	local coins_lb = plane:getChildByName(CHILD_NAME_COINS)

	local infos = {}
	infos["icon_url"] = photoUrl
	infos["uid"] = userInfo["uid"]
	infos["sex"] = userInfo["sex"]
	require("hall.GameCommon"):setPlayerHead(infos, portrait, 46)

	nick_lb:setString(require("hall.GameCommon"):formatNick(nickname))

	-- require("hall.GameCommon"):formatLabelStr(nickname, nick_lb, nick_lb:getSize().width)
	coins_lb:setString(coins)

	self:showNetworkImg(plane, false)
end

function UserInfoPlaneOperator:showZhuang(isShow, plane)
	local zhuang_signal = plane:getChildByName(CHILD_NAME_ZHUANG_SIGNAL)

	zhuang_signal:setVisible(isShow)
end

function UserInfoPlaneOperator:getHeadNode(plane)
	return plane:getChildByName(CHILD_NAME_PORTRAIT)
end

function UserInfoPlaneOperator:showNetworkImg(plane, flag)
	local img = plane:getChildByName(CHILD_NAME_NETWORK_IMG)

	if img then
		--todo
		img:setVisible(flag)
	end
end

function UserInfoPlaneOperator:beginPlayCard(plane, flag)
	local img = plane:getChildByName("turn_img")
     
	if img then
		if flag ==true then
            img:setVisible(true)

			local showTurnAc = cc.CallFunc:create(function()
					if img:getOpacity() > 220 then		
						img:fadeTo(1.3, 50)

					elseif img:getOpacity()<80 then	
						img:fadeTo(1.3, 255)
					end

				end)

			seqAc = cc.Sequence:create(cc.DelayTime:create(1.3), showTurnAc)
			img:runAction(cc.RepeatForever:create(seqAc))

		else
		 	img:setVisible(false)
		end
	end
end


return UserInfoPlaneOperator