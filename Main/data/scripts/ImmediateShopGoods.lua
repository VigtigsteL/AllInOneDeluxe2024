function Create()
    for i=1,10 do
		local ShopGoods = Object.Spawn("ShopGoods", this.Pos.x, this.Pos.y)
	end
	this.Delete()
end