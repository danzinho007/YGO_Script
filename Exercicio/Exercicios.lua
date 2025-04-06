--Lista ordem alfabética:
--Jar of Greed = 003 (Postado)
--Link Aranha = 001 (Postado)
--Pot of Greed = 004
--Skelengel = 05 (Postado)
--Tiragon Bebê = 002 (Postado)

--Resumo:
--001 Link Aranha
--002 Tiragon Bebê
--003 Jar of Greed
--004 Pot of Greed
--005 Skelengel
--006
--007
--008
--009
--010
--011
--012
--013
--014
--015
--016
--017
--018
--019
--020
--021
--022
--023
--024
--025
--026
--027
--028
--029
--030

--Exemplo_01: Link Aranha
--Monstro Efeito Link 1 Terra Ciberso
--Link 1, seta pra baixo, 1 monstro normal
--Fase Principal : 1x por turno você pode fazer invocação especial de Lv 4 ou menor normal da mão para a zona que está apontada essa carta

local s,id=GetID()
function s.initial_effect()
--Invocação Link ( Requisitos )
	Link.AddProcedure(c,aux.FilterBoolFunctionEx(Card.IsType,TYPE_NORMAL),1,1)
    c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.String(id,0))
	e1:SetDescription(aux.String(id,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
-	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
function s.filter(c,e,tp,zone)
	return c:IsLevelBelow(4) and c:IsType(TYPE_NORMAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk== 0 then
		local zone=e:GetHandler():GetLinkedZone(tp)
		return zone~= and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_HAND,0,1,nil,e,tp,zone)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local zone=e:GetHandler():GetLinkedZone(tp)
	if zonne==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp,zone)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end

==============
--Modelo Raiz: Exercício 02 Tiragon Bebê
--Nome em Japones / Inglês / Português
--Monstro Efeito XYZ Terra Dragão
--3 monstros de nível 1
--Efeito 
-- Durante sua Fase Principal 1: Você pode desassociar 1 matéria xyz desta carta e depois escolher 1 monstro nível 1 que você controle, ele pode atacar diretamente o oponente
local s,id=GetID()
function s.initial_effect()
--Invocação XYZ
    Xyz.AddProcedure(c,nil,1,3)
    c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.String(id,0))
	--e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetRange(LOCATION_MZONE)
    --e1:SetCountLimit()
    e1:SetCondition(s.condition)
    e1:SetCost(s.cost)
	e1:SetCountLimit(1)
-	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
    c:RegisterEffect(e1,false,REGISTER_FLAG_DETACH_XMAT)
function s.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
    e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function s.filter(c)
    return c:IsFaceup() and c:GetLevel()==1 and c:GetEffectCount(EFFECT_DIRECT_ATTACK)==0
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_MZONE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
    Duel.SelectTarget(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp,chk)
--Pega o primeiro alvo selecionado pelo efeito — no caso, aquele monstro Nível 1 com a face para cima que o jogador escolheu na função target.
    local tc=Duel.GetFirstTarget()
--Verifica se:
--O monstro ainda está com a face para cima;
--E ainda está no campo e ligado ao efeito, ou seja, não foi destruído ou movido antes do efeito resolver.
    if tc:IsFaceup() and tc:IsRelateToEffect(e) then
        local e1=Effect.CreateEffect(e:GetHandler())
--Efeito afeta somente 1 carta escolhida:
        e1:SetType(EFFECT_TYPE_SINGLE)
--Efeito que permite a carta escolhida atacar diretamente:
        e1:SetCode(EFFECT_DIRECT_ATTACK)
--Efeito de atacar diretamente dura até o final do turno ou até o monstro sair do campo / ser virado pra baixo
        e1:SetReset(RESET_EVENT+RESETS_STANDARD)
--Registra o efeito e agora o monstro escolhido pode atacar diretamente nesse turno :
        tc:RegisterEffect(e1)
    end
end
================================
Exercicio 03
--強欲な瓶 / Jar of Greed
--Arm-Compre 1 carta
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

==================================================
Exercicio 04
--強欲な壺
--Pot of Greed
--Magia Normal 
--Compre 2 cartas
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

=======================================================
Exercicio 05
--スケルエンジェル
local s,id=GetID()
function s.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
