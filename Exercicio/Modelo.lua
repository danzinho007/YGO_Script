--Modelo Raiz:
--Nome em Japones / Nome em Ingles / Nome em Portugues
--Categoria da carta / Atributo / Tipo / Ataque / Defesa
--Quantos monstros pra ser invocado ?
--Efeito: 
local s,id=GetID()
function s.initial_effect()
--Invocação Link (Requisitos)
	Link.AddProcedure(c,aux.FilterBoolFunctionEx(Card.IsType,TYPE_NORMAL),1,1)
    c:EnableReviveLimit()
--Invocação XYZ (Requisitos)
	Xyz.AddProcedure(c,nil,1,3)
	c:EnableReviveLimit()

	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.String(id,0))
	e1:SetDescription(aux.String(id,1))
	e1:SetCategory()
	e1:SetType()
    e1:SetProperty()
	e1:SetRange()
	e1:SetCode()
	e1:SetCountLimit()
-	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetCurrentPhase()
end  
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return ... end
end
function s.filter(c,e,tp,zone)
	return c:IsLevelBelow(4)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return ... end
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)

end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=
end












https://animesonline.gratis/lista-de-animes/
https://animesdigital.org/animes-legendados-online?filter_letter=S&type_url=animes&filter_audio=legendado&filter_order=name&filter_genre_add=&filter_genre_del=&pagina=4&search=0&limit=30
https://animesdigital.org/animes-dublado/?filter_letter=S&type_url=animes&filter_audio=dublado&filter_order=name&filter_genre_add=&filter_genre_del=&pagina=1&search=0&limit=30

Anime 
https://animefire.plus/
https://animefire.plus/lista-de-filmes-dublados?letra=M
Anime : Elsword 
https://animefire.plus/animes/elsword-el-ui-yeoin-todos-os-episodios