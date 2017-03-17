local _ local SellerHelper_1d8297e34b005d412b128ad7b6dee346={} local SellerHelper_b7a7bb3b145216887f0044d1b8b2edf4 ={} local SellerHelper_24c8020537b1ca32fb4f66f81da1d920 = nil; local SellerHelper_54a8f96492d95c1b6673ee8807d801ad=nil local SellerHelper_336d4cf4119146524a8cd136a76751dc,SellerHelper_1f36c8d2dae5d47ea2a778817f5d1261 local _version = "4.01"; if ( GetLocale() == "zhCN" ) then AUTO_RECHARGE_HELP_TEXT = " 点击物品名称可修改要自动购买该物品的数量。"; SellerHelper_AUTOBUY_ADD_TEXT="添加到自动购买列表"; AUTOSELL_AUTOBUY_ITEM_TEXT="%s\n将添加到自动购买列表"; AUTOSELL_AUTRECHARGE_ITEM_TEXT = "将要从自动购买列表中移除：\n%s"; AUTOSELL_AUTOBUY_ITEM_ACCEPTTEXT = "%s"; AUTOSELL_AUTOBUY_DELETE_TEXT="取消自动购买"; AUTO_RECHARGE_TITLE = "购买助手"; AUTO_RECHARGE_TITLE_STATE=": 买入/当前 - " elseif (GetLocale() == "zhTW") then AUTO_RECHARGE_HELP_TEXT =" 點擊物品名稱可修改要自動購買該物品的數量。"; AUTOSELL_AUTOBUY_ITEM_TEXT="%s\n將添加到自動購買列裱"; AUTOSELL_AUTRECHARGE_ITEM_TEXT = "將要從自動購買列裱中移除：\n%s"; AUTOSELL_AUTOBUY_ITEM_ACCEPTTEXT = "%s"; SellerHelper_AUTOBUY_ADD_TEXT="添加到自動購買列表"; AUTOSELL_AUTOBUY_DELETE_TEXT="取消自動購買"; AUTO_RECHARGE_TITLE = "購買助手"; AUTO_RECHARGE_TITLE_STATE=": 買入/當前 - " else AUTO_RECHARGE_HELP_TEXT ="The automatic purchase goods' greatest quantity is 999"; SellerHelper_AUTOBUY_ADD_TEXT="Auto Recharge To List"; AUTOSELL_AUTOBUY_ITEM_TEXT="%s\nWill been set to auto-buy item"; AUTOSELL_AUTRECHARGE_ITEM_TEXT = "Will be removed from auto-buy list：\n%s"; AUTOSELL_AUTOBUY_ITEM_ACCEPTTEXT = "%s"; AUTOSELL_AUTOBUY_DELETE_TEXT="Cancel automatically buy"; AUTO_RECHARGE_TITLE = "Auto Recharge"; AUTO_RECHARGE_TITLE_STATE=": Buy/Now - " end StaticPopupDialogs["AUTOSELL_AUTOBUY_ITEM"] = { text = AUTOSELL_AUTOBUY_ITEM_TEXT, button1 = TEXT(OKAY), button2 = TEXT(CANCEL), OnAccept = function() AR_Frame_OnAddItem() end, showAlert = 1, timeout = 0, hideOnEscape = 1 }; StaticPopupDialogs["AUTOSELL_AUTRECHARGE_ITEM"] = { text = AUTOSELL_AUTRECHARGE_ITEM_TEXT, button1 = TEXT(OKAY), button2 = TEXT(CANCEL), OnAccept = function() if(SellerHelper_54a8f96492d95c1b6673ee8807d801ad ~=nil) then AR_CFG_DeleteARItem(SellerHelper_54a8f96492d95c1b6673ee8807d801ad) AR_UpdatePanel() end end, showAlert = 1, timeout = 0, hideOnEscape = 1 }; StaticPopupDialogs["AUTOSELL_AUTOBUY_ITEM_CONFIRM"] = { text =AUTOSELL_AUTOBUY_ITEM_ACCEPTTEXT, button1 = TEXT(OKAY), button2 = TEXT(CANCEL), OnAccept = function() AR_Buy(SellerHelper_336d4cf4119146524a8cd136a76751dc,SellerHelper_1f36c8d2dae5d47ea2a778817f5d1261) AR_UpdatePanel() end, timeout = 30, hideOnEscape = 1 }; local function SellerHelper_4f9ef689ec2dcfa9d769b6932187e054() if AR_ItemInfo and AR_ItemInfo.version ~= "4.01" then AutoRechargeSetting = {} AR_ItemInfo = {} AR_ItemInfo.version = "4.01" return end if not AutoRechargeSetting then AutoRechargeSetting = {} end AR_ItemInfo = AR_ItemInfo or {} AR_ItemInfo.version = "4.01" end function AR_CFG_DeleteARItem(itemName) if AutoRechargeSetting and AutoRechargeSetting[itemName] then AutoRechargeSetting[itemName] = nil AR_ItemInfo[itemName] = nil end end local function SellerHelper_dab29a9c52ce6bd796abba1b6f78217f(itemName,texture,hyperLink,quantity) if AutoRechargeSetting and not AutoRechargeSetting[itemName] then AutoRechargeSetting[itemName] = 1 AR_ItemInfo[itemName] = {}; AR_ItemInfo[itemName].texture = texture AR_ItemInfo[itemName].hyperLink = hyperLink AR_ItemInfo[itemName].stack = 1 AR_ItemInfo[itemName].addtime = time() end end function AR_Frame_OnAddItem() local index=StaticPopupDialogs["AUTOSELL_AUTOBUY_ITEM"].itemid local itemName,texture,_,quantity = GetMerchantItemInfo(index) local hyperLink = GetMerchantItemLink(index) SellerHelper_dab29a9c52ce6bd796abba1b6f78217f(itemName,texture,hyperLink,quantity) AutoRechargeFrame.selectedItem = itemName AR_UpdatePanel() local _id; for id,_table in pairs(SellerHelper_b7a7bb3b145216887f0044d1b8b2edf4) do if itemName == _table[1] then _id=id end end if _id and _id>8 then FauxScrollFrame_OnVerticalScroll(AutoRechargeFrameScrollFrame, (_id-8)*35, SELLER_HELPER_FRAME_ITEM_HEIGHT, AR_UpdatePanel) else FauxScrollFrame_OnVerticalScroll(AutoRechargeFrameScrollFrame, 0, SELLER_HELPER_FRAME_ITEM_HEIGHT, AR_UpdatePanel) end ClearCursor() end function AR_CFG_SetCount(itemName,count) if AutoRechargeSetting and AutoRechargeSetting[itemName] then AutoRechargeSetting[itemName] = count end end function AR_ScanMerchant() if not AutoRechargeSetting then return end if not MerchantFrame:IsVisible() then return end local merItemCount = GetMerchantNumItems() local merchantARList = {} for i = 1, merItemCount do local itemName = GetMerchantItemInfo(i) local itemCount = AutoRechargeSetting[itemName] if itemCount and itemCount >0 then merchantARList[itemName] = i end end return merchantARList end function AR_ScanPlayer() if not AutoRechargeSetting then return end if not MerchantFrame:IsVisible() then return end local SellerHelper_1f194f793e9150819d886c66d5bc23b5, SellerHelper_3f50417fb16be9b1078eb68d24fa9c26; local playerARList = {} for SellerHelper_8983c60d66c8593ec7165ea9dbedb584,SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 in pairs(AutoRechargeSetting) do playerARList[SellerHelper_8983c60d66c8593ec7165ea9dbedb584] = SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 end for SellerHelper_96ec47e10d09a5d0491fe767488c7fab = 0, NUM_BAG_FRAMES do local SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed = GetContainerNumSlots(SellerHelper_96ec47e10d09a5d0491fe767488c7fab); if (SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed and SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed > 0) then for SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d =SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed, 1, -1 do SellerHelper_1f194f793e9150819d886c66d5bc23b5,_,_,_,SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 = SellerHelper_ffc6f36e205c615c838d2b0370235e96(SellerHelper_96ec47e10d09a5d0491fe767488c7fab, SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d, false); if playerARList[SellerHelper_1f194f793e9150819d886c66d5bc23b5] then playerARList[SellerHelper_1f194f793e9150819d886c66d5bc23b5] = max(playerARList[SellerHelper_1f194f793e9150819d886c66d5bc23b5]-SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,0) if playerARList[SellerHelper_1f194f793e9150819d886c66d5bc23b5]==0 then playerARList[SellerHelper_1f194f793e9150819d886c66d5bc23b5] = nil end end end end end return playerARList end function AR_Buy(merchantList, playerList) local merIndex,quantityPerBuy,buyNumber,maxCanBuy; for SellerHelper_8983c60d66c8593ec7165ea9dbedb584,SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 in pairs(playerList) do if SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 and SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 >0 then merIndex = merchantList[SellerHelper_8983c60d66c8593ec7165ea9dbedb584] if merIndex and merIndex >=0 then quantityPerBuy = AR_ItemInfo[SellerHelper_8983c60d66c8593ec7165ea9dbedb584].stack if quantityPerBuy and quantityPerBuy > 0 then buyNumber = ceil(SellerHelper_3f50417fb16be9b1078eb68d24fa9c26/quantityPerBuy) maxCanBuy = GetMerchantItemMaxStack(merIndex); for i = 1, floor(buyNumber/maxCanBuy) do BuyMerchantItem(merIndex,maxCanBuy) end if buyNumber%maxCanBuy > 0 then BuyMerchantItem(merIndex,buyNumber%maxCanBuy) end end end end end end function AR_CancelBuy(self) local link=self:GetParent().hyperLink if (link) then SellerHelper_54a8f96492d95c1b6673ee8807d801ad=self:GetParent().itemName AR_CFG_DeleteARItem(SellerHelper_54a8f96492d95c1b6673ee8807d801ad) AR_UpdatePanel() end end function AR_DoRecharge() SellerHelper_336d4cf4119146524a8cd136a76751dc = AR_ScanMerchant() SellerHelper_1f36c8d2dae5d47ea2a778817f5d1261 = AR_ScanPlayer() if not SellerHelper_336d4cf4119146524a8cd136a76751dc or not SellerHelper_1f36c8d2dae5d47ea2a778817f5d1261 then return end local text=""; local merIndex,quantityPerBuy,link; for SellerHelper_8983c60d66c8593ec7165ea9dbedb584,SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 in pairs(SellerHelper_1f36c8d2dae5d47ea2a778817f5d1261) do if SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 and SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 >0 then merIndex = SellerHelper_336d4cf4119146524a8cd136a76751dc[SellerHelper_8983c60d66c8593ec7165ea9dbedb584] if merIndex and merIndex >=0 and AR_ItemInfo and AR_ItemInfo[SellerHelper_8983c60d66c8593ec7165ea9dbedb584] then quantityPerBuy = AR_ItemInfo[SellerHelper_8983c60d66c8593ec7165ea9dbedb584].stack; link=AR_ItemInfo[SellerHelper_8983c60d66c8593ec7165ea9dbedb584].hyperLink; if quantityPerBuy and quantityPerBuy > 0 then if quantityPerBuy ~=1 then if SellerHelper_3f50417fb16be9b1078eb68d24fa9c26>=quantityPerBuy then text = text .. link .. AUTO_RECHARGE_TITLE_STATE .. (ceil(SellerHelper_3f50417fb16be9b1078eb68d24fa9c26/quantityPerBuy)*quantityPerBuy).."/"..(AutoRechargeSetting[SellerHelper_8983c60d66c8593ec7165ea9dbedb584]-SellerHelper_3f50417fb16be9b1078eb68d24fa9c26).. "\n"; elseif quantityPerBuy>SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 then text = text .. link .. AUTO_RECHARGE_TITLE_STATE .. quantityPerBuy.."/"..(AutoRechargeSetting[SellerHelper_8983c60d66c8593ec7165ea9dbedb584]-SellerHelper_3f50417fb16be9b1078eb68d24fa9c26) .. "\n"; end else text = text .. link .. AUTO_RECHARGE_TITLE_STATE .. SellerHelper_3f50417fb16be9b1078eb68d24fa9c26.."/"..(AutoRechargeSetting[SellerHelper_8983c60d66c8593ec7165ea9dbedb584]-SellerHelper_3f50417fb16be9b1078eb68d24fa9c26) .. "\n"; end if(SellerHelper_24c8020537b1ca32fb4f66f81da1d920) then StaticPopup_Show("AUTOSELL_AUTOBUY_ITEM_CONFIRM", text); else AR_Buy(SellerHelper_336d4cf4119146524a8cd136a76751dc,SellerHelper_1f36c8d2dae5d47ea2a778817f5d1261) AR_UpdatePanel() end end end end end end function AR_UpdatePanel() if not AutoRechargeSetting then return end for i = 1, ITEMS_TO_DISPLAY do _G["AutoRechargeFrameItem"..i]:Hide() end SellerHelper_b7a7bb3b145216887f0044d1b8b2edf4 ={} for SellerHelper_8983c60d66c8593ec7165ea9dbedb584,SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 in pairs(AutoRechargeSetting) do if AR_ItemInfo[SellerHelper_8983c60d66c8593ec7165ea9dbedb584] and AR_ItemInfo[SellerHelper_8983c60d66c8593ec7165ea9dbedb584].addtime then tinsert(SellerHelper_b7a7bb3b145216887f0044d1b8b2edf4,{SellerHelper_8983c60d66c8593ec7165ea9dbedb584,SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,AR_ItemInfo[SellerHelper_8983c60d66c8593ec7165ea9dbedb584].addtime}) end end local function sortByTime(a,b) if not a or not b then return false end if not a[3] or not b[3] then return false end return a[3] >= b[3] end table.sort(SellerHelper_b7a7bb3b145216887f0044d1b8b2edf4,sortByTime) local index = 0; local offset = FauxScrollFrame_GetOffset(AutoRechargeFrameScrollFrame) + 1; for _,_table in pairs(SellerHelper_b7a7bb3b145216887f0044d1b8b2edf4) do local SellerHelper_8983c60d66c8593ec7165ea9dbedb584, SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 = _table[1],_table[2] index = index + 1; if index >= offset and index <offset + 8 then local frame = _G["AutoRechargeFrameItem"..(index + 1 - offset)] if frame then AR_UpdateItem(_G["AutoRechargeFrameItem"..(index + 1 - offset)],SellerHelper_8983c60d66c8593ec7165ea9dbedb584,SellerHelper_3f50417fb16be9b1078eb68d24fa9c26) if frame.itemName ==AutoRechargeFrame.selectedItem then _G[frame:GetName().."SpinBoxCount"]:SetFocus() end end end end FauxScrollFrame_Update(AutoRechargeFrameScrollFrame, index, ITEMS_TO_DISPLAY, SELLER_HELPER_FRAME_ITEM_HEIGHT ); end function AR_UpdateItem(frame,itemName,ItemCount) if itemName and AR_ItemInfo[itemName] then _G[frame:GetName().."Name"]:SetText(itemName); local iconTexture = AR_ItemInfo[itemName].texture if ItemCount then _G[frame:GetName().."SpinBoxCount"]:SetText(ItemCount); end if iconTexture then _G[frame:GetName().."ItemIconTexture"]:SetTexture(iconTexture); end frame.itemName = itemName frame.hyperLink = AR_ItemInfo[itemName].hyperLink if frame.itemName ==frame:GetParent().selectedItem then frame:LockHighlight() else frame:UnlockHighlight() end frame:Show() end end function AR_EditBox_OnEditFocusLost(self) local frame = self:GetParent():GetParent(); local itemName = frame.itemName local value = self:GetNumber(); if (value<=1) then self:SetNumber(1); end if (value>=9999) then self:SetNumber(9999); end value = self:GetNumber(); AR_UpdateItem(frame,itemName,value) AR_CFG_SetCount(itemName,value) end function AR_ItemButton_OnClick(frame) local parent = frame:GetParent() parent.selectedItem = frame.itemName AR_UpdatePanel() end function AR_Frame_OnLoad(self) local lastBtn; for i=1, ITEMS_TO_DISPLAY do SellerHelper_1d8297e34b005d412b128ad7b6dee346[i] = CreateFrame("Button", "AutoRechargeFrameItem" .. i, self, "AutoRechargeItemTemplate"); SellerHelper_1d8297e34b005d412b128ad7b6dee346[i]:SetID(i); if (i == 1) then SellerHelper_1d8297e34b005d412b128ad7b6dee346[i]:SetPoint("TOPLEFT", self, "TOPLEFT", 38, -90); else SellerHelper_1d8297e34b005d412b128ad7b6dee346[i]:SetPoint("TOPLEFT", lastBtn, "BOTTOMLEFT", 0, -3); end lastBtn = SellerHelper_1d8297e34b005d412b128ad7b6dee346[i]; end end function ToogleAutoBuyButton(flag) if flag then for i in ipairs (SellerHelper_AutobuyAddItemButton) do SellerHelper_AutobuyAddItemButton[i]:Show() end else for i in ipairs (SellerHelper_AutobuyAddItemButton) do SellerHelper_AutobuyAddItemButton[i]:Hide() end end end local AR_Eventer = BLibrary("BEvent"); function AR_Toggle(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae) if ( SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1 ) then SellerHelper_4f9ef689ec2dcfa9d769b6932187e054() AR_Eventer:RegisterEvent("MERCHANT_SHOW", AR_DoRecharge); hooksecurefunc("MerchantFrame_UpdateMerchantInfo",function() ToogleAutoBuyButton(true) end) hooksecurefunc("MerchantFrame_UpdateBuybackInfo",function() ToogleAutoBuyButton(false) end) else AR_Eventer:UnregisterAllEvent() hooksecurefunc("MerchantFrame_UpdateMerchantInfo",function() ToogleAutoBuyButton(false) end) end end function SellHelper_AddButton_OnClick(self) local link =self:GetParent().link if(link) then if (not AutoRechargeFrame:IsVisible()) then SellerHelperParentFrame:Show(); SellerHelperParentFrameTab_OnClick(nil, nil, 2); end StaticPopupDialogs["AUTOSELL_AUTOBUY_ITEM"].itemid = (MerchantFrame.page -1)* MERCHANT_ITEMS_PER_PAGE + self:GetID(); AR_Frame_OnAddItem() end end function GetItemID(link) local itemid; if (link and type(link) == "string") then itemid = strmatch(link, "|c%x+|Hitem:(%d+):.+|h%[.-%]|h|r"); end return itemid; end function MerchantSpinBox_OnShow(self) local parent = self:GetParent(); local editbox = _G[self:GetName() .. "Count"]; local itemName = parent.itemName editbox:SetNumber(AutoRechargeSetting[itemName]); end function MerchantSpinBoxPrev_OnClick(self) local parent = self:GetParent():GetParent(); local itemName = parent.itemName local editbox = _G[self:GetParent():GetName() .. "Count"]; local value = editbox:GetNumber(); editbox:SetNumber(value-1); end function MerchantSpinBoxNext_OnClick(self) local parent = self:GetParent():GetParent(); local itemName = parent.itemName local editbox = _G[self:GetParent():GetName() .. "Count"]; local value = editbox:GetNumber(); editbox:SetNumber(value+1); end function AR_AcceptToggle(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae) if ( SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1 ) then SellerHelper_24c8020537b1ca32fb4f66f81da1d920 = 1; else SellerHelper_24c8020537b1ca32fb4f66f81da1d920 = nil; end end 
