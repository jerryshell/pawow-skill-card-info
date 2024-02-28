local function GetCollectedSpellIDs()
    local result = {}
    local maxIndex = SkillCardsFrame.ScrollListNormal:GetNumResults()
    for index = 1, maxIndex do
        if SkillCardsFrame.ScrollListNormal:GetItemData(index).IsCollected then
            table.insert(result, SkillCardsFrame.ScrollListNormal:GetItemData(index).SpellID)
        end
    end
    local maxIndex = SkillCardsFrame.ScrollListGolden:GetNumResults()
    for index = 1, maxIndex do
        if SkillCardsFrame.ScrollListGolden:GetItemData(index).IsCollected then
            table.insert(result, SkillCardsFrame.ScrollListGolden:GetItemData(index).SpellID)
        end
    end
    return result
end

function SetInfo()
    local collectedSpellIDs = GetCollectedSpellIDs()
    local output = table.concat(collectedSpellIDs, ",")
    InfoButton:SetText(output)
end

local MainFrame = CreateFrame("Frame", "GetSkillCardInfoFrame", UIParent)

MainFrame:SetPoint("TOPLEFT", 205, -45)
MainFrame:SetFrameStrata("MEDIUM")
MainFrame:SetSize(220, 150)

MainFrame:SetClampedToScreen(true)
MainFrame:SetMovable(true)
MainFrame:EnableMouse(true)
MainFrame:RegisterForDrag("LeftButton")
MainFrame:SetScript("OnDragStart", MainFrame.StartMoving)
MainFrame:SetScript("OnHide", MainFrame.StopMovingOrSizing)
MainFrame:SetScript("OnDragStop", MainFrame.StopMovingOrSizing)
MainFrame:Show()

MainFrame.BG = MainFrame:CreateTexture()
MainFrame.BG:SetAllPoints()
MainFrame.BG:SetTexture(0.1, 0.1, 0.1, 1)

local button = CreateFrame("Button", "Frame", MainFrame, "UIPanelButtonTemplate")
button:SetSize(200, 30)
button:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -28);
button:SetText("获取技能卡信息")
button:Show()
button:SetScript("OnClick", function()
    local collectedSpellIDs = GetCollectedSpellIDs()
    local output = ""
    for _, spellID in ipairs(collectedSpellIDs) do
        if output ~= "" then
            output = output .. ","
        end
        output = output .. spellID
    end
    InfoButton:SetText(output)
end)
local preWidget = button

local editBox = CreateFrame("EditBox", "Frame", MainFrame, "InputBoxTemplate")
editBox:SetSize(200, 30)
editBox:SetPoint("TOPLEFT", preWidget, "BOTTOMLEFT", 0, -3)
editBox:SetText("请点击 获取技能卡信息 按钮")
editBox:Show()
if editBox:IsAutoFocus() then
    editBox:SetAutoFocus(false)
end
local preWidget = editBox
InfoButton = editBox

local closeButton = CreateFrame("Button", "Frame", MainFrame, "UIPanelButtonTemplate")
closeButton:SetSize(200, 30)
closeButton:SetPoint("TOPLEFT", preWidget, "BOTTOMLEFT", 0, -3)
closeButton:SetText("关闭窗口")
closeButton:Show()
closeButton:SetScript("OnClick", function()
    MainFrame:Hide()
end)
-- local preWidget = closeButton

SlashCmdList["GETSKILLCARDINFO"] = function()
    if MainFrame and not MainFrame:IsVisible() then
        MainFrame:Show()
    end
end
SLASH_GETSKILLCARDINFO1 = "/getskillcardinfo"
