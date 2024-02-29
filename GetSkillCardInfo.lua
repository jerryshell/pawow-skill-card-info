function GetCollectedSpellIDs()
    local result = {}
    SkillCardsFrameTab3:Click()
    SkillCardsFrame:ClearFilters()
    local maxIndex = C_SkillCardCollection.GetNumSkillCards(Enum.SkillCardType.SkillNormal)
    for index = 1, maxIndex do
        local data = C_SkillCardCollection.GetSkillCardAtIndex(Enum.SkillCardType.SkillNormal, index)
        if data.IsCollected then
            table.insert(result, data.SpellID)
        end
    end
    local maxIndex = C_SkillCardCollection.GetNumSkillCards(Enum.SkillCardType.SkillGolden)
    for index = 1, maxIndex do
        local data = C_SkillCardCollection.GetSkillCardAtIndex(Enum.SkillCardType.SkillGolden, index)
        if data.IsCollected then
            table.insert(result, data.SpellID)
        end
    end
    local maxIndex = C_SkillCardCollection.GetNumSkillCards(Enum.SkillCardType.TalentNormal)
    for index = 1, maxIndex do
        local data = C_SkillCardCollection.GetSkillCardAtIndex(Enum.SkillCardType.TalentNormal, index)
        if data.IsCollected then
            table.insert(result, data.SpellID)
        end
    end
    local maxIndex = C_SkillCardCollection.GetNumSkillCards(Enum.SkillCardType.TalentGolden)
    for index = 1, maxIndex do
        local data = C_SkillCardCollection.GetSkillCardAtIndex(Enum.SkillCardType.TalentGolden, index)
        if data.IsCollected then
            table.insert(result, data.SpellID)
        end
    end
    return result
end

local MainFrame = CreateFrame("Frame", "GetSkillCardInfoFrame", UIParent, "SimplePanelTemplate")

MainFrame:SetPoint("TOPLEFT", 200, -45)
MainFrame:SetFrameStrata("MEDIUM")
MainFrame:SetSize(380, 330)
MainFrame:SetClampedToScreen(true)
MainFrame:SetMovable(true)
MainFrame:EnableMouse(true)
MainFrame:RegisterForDrag("LeftButton")
MainFrame:SetScript("OnDragStart", MainFrame.StartMoving)
MainFrame:SetScript("OnHide", MainFrame.StopMovingOrSizing)
MainFrame:SetScript("OnDragStop", MainFrame.StopMovingOrSizing)
MainFrame:Show()

local fs = MainFrame:CreateFontString(nil, "OVERLAY", "GameTooltipText")
fs:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -10)
fs:SetText("S9 赛季 BD 助手 - Bilibili@devzero")

local button = CreateFrame("Button", nil, MainFrame, "UIPanelButtonTemplate")
button:SetSize(100, 30)
button:SetPoint("TOPLEFT", MainFrame, "TOPLEFT", 8, -28)
button:SetText("获取技能卡信息")
button:Show()
button:SetScript("OnClick", function()
    local collectedSpellIDs = GetCollectedSpellIDs()
    local output = table.concat(collectedSpellIDs, ",")
    SkillCardInfoBox:SetText(output)
end)
local preWidget = button

local scrollFrame = CreateFrame("ScrollFrame", nil, MainFrame, "ScrollableMultiLineInputBoxInstructionsTemplate")
scrollFrame:SetSize(340, 200)
scrollFrame:SetPoint("TOPLEFT", preWidget, "BOTTOMLEFT", 0, -3)
SkillCardInfoBox = scrollFrame:GetScrollChild()
SkillCardInfoBox:SetText(
    "使用方法说明：\n1. 点击 [获取技能卡信息] 按钮\n2. 复制技能卡信息，粘贴到网站中即可\nCtrl + A 全选\nCtrl + C 复制\n使用 /getskillcardinfo 命令可以重新打开窗口"
)

local preWidget = scrollFrame

local closeButton = CreateFrame("Button", nil, MainFrame, "UIPanelButtonTemplate")
closeButton:SetSize(100, 30)
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
