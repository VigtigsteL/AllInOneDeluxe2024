-- RotateObject --


function look_around(types, cb, range, justOne)
	local count = 0
	if range == "max" then range = 9999 end
	for k, v in pairs(types) do
		local os = this.GetNearbyObjects(v, (range or nearbyRange))
		for o, distance in pairs( os ) do
			count = count + 1
			if cb then
				cb(o, distance)
			end
			if justOne then return o end
		end
	end
	if justOne then
		return nil
	else
		return count
	end
end




function Create()
	rotateThose()
	this.Hidden = true
	this.Delete()
end

local wallTypeDict = {ConcreteWall=true, BrickWall=true, BurntWall=true, Fence=true, PerimeterWall=true}


local objTypes = {'Toilet','ShowerHead','ShowerPillar','Drain','WoodDrain','BathroomSink','PersonalSink','SinkMirror','BathroomHandDryer','LaundryMachine','IroningBoard','IroningBoardShort','LaundryBasket','Light','WallLight','SolarLight','SolarWallLight','StreetLamp','FloodLight','SearchLight','AdvancedSearchLight','Chandelier','OrnateLantern','Lamp','LightGreen','LightRed','Radio','BoomBoxRoundhouse','Tv','LargeTv','CinemaScreen','CinemaProjector','ArcadeCabinet','PoolTable','TableTennis','TableFootball','Canvas','ChessTable','PlayMat','VisitorTable','PhoneBooth','VideoCallBooth','VisitorTableSecure','PetBird','Bookshelf','Blackboard','ComputerStation','ShortBookcase','ShortBookcase','Altar','Pews','PrayerMat','Fan','GangGraffiti','TattooRemovalMachine','WorkshopSaw','WorkshopPress','CarpenterTable','SortingTable','ShopFront','ShopCounter','ShopShelf','AccountingTable','Shed','BasicAutoGatherer','AdvancedAutoGatherer','AutoScythe','AutoHarvester','DripPipe','CropSprinkler','CompostBin','StorageShelf','PracticeSolarPanel','SoftPillow','Bed','Mattress','OldBed','BunkBed','CoffinBed','ComfyBed','SuperiorBed','Crib','CampBed','NettedBed','WoodenStool','WoodenTable','JungleBench','JungleTable','Table','Bench','SmallTable','SmallBench','OakTable','OakBench','SchoolDesk','FilingCabinet','OfficeDesk','ChestOfDrawers','SwivelChair','FancyDesk','OfficeChair','FilingCabinetFancy','OutdoorTable','Chair','ChairYellow','SofaChairSingle','SofaChairDouble','SofaChairBrown','SofaChairDoubleBrown','LeatherChair','LeatherSofa','OvalStaffTable','DeckChair','MetalStool','ParkBench','Bleachers','Window','WindowLarge','WoodenWindowSmall','WoodenWindowLarge','GlassWindow','GlassWindowLarge','WindowClassy','WindowClassyLarge','StainGlassWindow','WeightsBench','GymMat','DumbbellRack','Treadmill','PunchBag','TrainingDummy','TyreApparatus','FightRing','PullUpBars','KneeRaise','PushUpStones','BoxingRing','FirePit','TreeVines','TyreStack','DoorMat','BorderPlantA','BorderPlantB','BorderPlantC','Painting1','Painting2','Banner','ClimbingRope','CoatStand','MooseHead','Gravestone','WoodenBarrel','MetalBarrel','StoneWaterSpout','Fountain','GardenGnome','TopiaryBush','TopiaryBushBall','TopiaryBushWarden','TopiaryBushSwan','TopiaryBushDeer','TopiaryBushDog','TopiaryBushCat','TopiaryBushRex','OxStatue','PaperDragonHead','PaperDragonBody','PaperDragonTail','PaperLantern','CoupletBanner','PinkFlamingo','FlowerPlanterWateringCan','FlowerPlanterWellies','FlowerPlanterWheelbarrow','HayBale','SpiderWeb','JackOLantern','DecoratedTree','WoodenDockFloor','WallPanel','WallPanelWood','WallPanelStone','WallPanelCorner_A','WallPanelWoodCorner_A','WallPanelStoneCorner_A','WallPanelCorner_B','WallPanelWoodCorner_B','WallPanelStoneCorner_B','Footbridge','GrassBridge','FootbridgeSteel','FootbridgeB','FootbridgeSteelB','Bin','RecyclingBin','Plant','PlantCactus','Ivy','Bush','FernBush','Tree','BareTree','CactusTree','SpookyTree','PalmTree','SnowyConiferTree','WillowTree','SakuraTree','IndoorTreePlanter','FallenTree','FallenTreeBig','TreeStump','CropCarrotPlant','CropPotatoPlant','CropTomatoPlant','CropCabbagePlant','CropCornPlant','CropWheatPlant','CropBarleyPlant','CropAppleTree','CropOrangeTree','CropPeachTree','CropBananaTree','FlowerRoseBush','FlowerSunflower','FlowerMixedBegonias','FlowerHeatherBushes','FlowerHydrangeaPlant','CompostFertilizer','HighQualityFertilizer','BakerySign','GymSign','NoEntrySign','PhoneSign','RestaurantSign','VisitationSign','ArmourySign','LeftArrowSign','RightArrowSign','CanteenSign','InfirmarySign','ShowerSign','ToiletSign','SignNumber0','SignNumber1','SignNumber2','SignNumber3','SignNumber4','SignNumber5','SignNumber6','SignNumber7','SignNumber8','SignNumber9','SignLetterA','SignLetterB','SignLetterC','SignLetterD','SignLetterE','SignLetterF','SignLetterG','SignLetterH','SignLetterI','SignLetterJ','SignLetterK','SignLetterL','SignLetterM','SignLetterN','SignLetterO','SignLetterP','SignLetterQ','SignLetterR','SignLetterS','SignLetterT','SignLetterU','SignLetterV','SignLetterW','SignLetterX','SignLetterY','SignLetterZ','FireExtinguisher','FireAlarm','Sprinkler','MetalDetector','WeaponRack','GuardLocker','DogCrate','DogDoo','RobotDogDoo','DogBowl','GuardTower','BambooGuardTower','GuardPavilion','GuardPavilionCorner','BarbedWire','WindSock','PASystem','TrackingMonitor','Cctv','CameraPillar','CctvMonitor','CctvCamo','Servo','ServoProxy','DoorTimer','DoorControlSystem','PhoneMonitor','TargetSorter','GangSorter','WardenStatue','ScannerMonitor','ScannerMachine','CheckPoint','DistractionContraption','MedicalBed','MedicineCabinet','MedicalBox','MorgueSlab','FirstAidStation','MedicineCabinetPsych','RorschachTest','AnatomyModel','Flipboard','TherapyAnimalContainer','TherapyAnimal','HealthMonitor','ElectricChair','Cooker','Sink','Fridge','TallFridge','ServingTable','SmallServingTable','JungleServingTable','TrayDispenser','FoodTrayPack','DisplayCounter','CakeStand','DiningTableLarge','DiningTableSmall','DinerBooth','Oven','DoughMixer','DiningChair','CoffeeMachine','DrinkingFountain','WaterCooler','SnackMachine','DrinkMachine','PowerStation','Capacitor','PowerCapacitorMaxPlus','ElectricalCable','WeatherAntenna','WeatherMachine','LightningRod','HeavyDutyElectricalCable','TrainingElectricalCable','WillBeDamagedElectricalCable','DamagedElectricalCable','BackupGenerator','WaterPumpStation','WaterBoiler','PipeValve','PipeLarge','PipeSmall','PipeHotWater','Radiator','PipeSmallLagged','PipeValveLagged','PipeHotLagged','WaterStationLagged','WaterBoilerLagged','WindTurbine','SolarWindHybrid','SolarPanels','PowerExportMeter','Transformer','Battery','PressurePad','PowerSwitch','LogicCircuit','LogicBridge','StatusLight','Wire','TidyWires','ShowAllWires','HitmanMarker','TargetDirection','SightMarker','HitmanReward','HitmanFine','DeathFine','A48Clothes','FlammableUniform','FakeExtinguisher','Explosion','CheatPrisonerMisbehavior','RoomCellMarker','RoomSelector','CloneSimple','CloneFlipX','CloneFlipY','CloneSpreadAligned','CloneSpreadAngled','MoveRoom','ClearSelector','MoveObjectMarker','MoveObject','RotateObject','LightHere','AttentionToPrisoner','AttentionMarker','TimeWarpNeedModifier','PCommand','CCommand','SwapOffice','SwapOfficeMarker','TimedCaller','MusterGuards','SearchToilets','Water','WaterWalkable','WaterShallow','WaterLarge','WaterBed','MurkyWater','MurkyWaterLarge','MurkyWaterShallow','MurkyWaterWalkable','MurkyWaterBed','SteppingStone','SteppingStoneLillyPad','SteppingStoneIceBlock','SteppingStonePallet','Dirt','Mud','NewMud','Sand','Grass','GrassCornerFloor','GrassCornerFloor1','GrassCornerFloor2','GrassCornerFloor3','FieldGrass','LongGrass','FlowerField','GrassStones','Sandstone','PavingStone','Gravel','Stone','JunglePath','RunningTrack','Road','RoadMarkings','RoadMarkingsLeft','RoadMarkingsRight','RoadCrossing','RoadCrossingLeft','RoadCrossingRight','Snow','LunarFloor','ConcreteFloor','YellowStraightLineTiles','YellowCornerLineTiles','ConcreteTiles','ConcreteMossFlooring','ConcreteLeavesFlooring','WoodenFloor','DarkWoodFloor','LaminateFlooringFR','BambooFloor','MetalFloor','NewIronFloor','NewCargoFloor','SolacoFloor','GrateFloor','Roof','BurntFloor','ReclaimedBrickFloor','ReclaimedRubberFloor','CeramicFloor','WhiteTiles','MosaicFloor','FancyTiles','NewCheckeredFloor','MarbleTiles','HexagonalTiles','TriangularTiles','LimestoneFloor','WeatheredStoneFlooring','BlueCarpet','BrownCarpet','RedCarpet','CarpetFR','ColouredStoneTiles','PaddedFloor','NewHedgeWall','HayBailWall','BambooFence','WoodenFence','WhitePicketFence','Fence','FenceAndGrass','NewBarredWall','RustyWall','SlumWall','DerelictWall','OvergrownWall','DecayedWall','ConcreteWall','WallMinSec','WallMedSec','WallMaxSec','WallSuperMaxSec','WallDeathRowSec','WallInsaneSec','WallProtective','BrickWall','NewBBlockWall','NewTiledWall','ArtDecoWall','OrientalWall','YutaniWall','ReclaimedWoodWall','BottleWall','GardenWall','BlueWall','BurgundyWall','CushionedWall','GreenWall','PerimeterWall','CliffEdge','FenceWall','CageFence','GlassWall','ElectrifiedFence','BurntWall','RustyFenceGrass','RustyFenceLongGrass','RoadGate','RoadBarrier','Door','DoubleDoor','BambooDoor','SaloonDoor','BarnDoor','WhitePicketGate','Gate','DoubleGate','CageGate','JailBars','KeycardDoor','KeycardDoorLarge','FenceGateStandard','FenceGateStaff','FenceGateGuard','FenceGateVisitor','SecretDoor','StaffDoor','StaffDoorBlue','StaffDoorOrange','VisitorDoor','DoubleStaffDoor','DoubleStaffDoorBlue','DoubleStaffDoorOrange','DoubleVisitorDoor','JailDoor','JailDoorGrey','JailDoorYellow','JailDoorOrange','JailDoorRed','JailDoorDarkRed','JailDoorBlack','JailDoorWhite','JailDoorRusty','JailDoorLarge','JailDoorLargeGrey','JailDoorLargeYellow','JailDoorLargeOrange','JailDoorLargeRed','JailDoorLargeDarkRed','JailDoorLargeBlack','JailDoorLargeWhite','JailDoorLargeRusty','JailDoorXL','JailDoorGreyXL','JailDoorOrangeXL','JailDoorRedXL','JailDoorDarkRedXL','JailDoorBlackXL','JailDoorYellowXL','JailDoorWhiteXL','SolitaryDoor','SecureDoor','RemoteDoor','RemoteDoorYellow','RemoteDoorOrange','RemoteDoorRed','RemoteDoorBlack','RemoteDoorWhite','RemoteDoorMaroon','CollapsedWall','CollapsedFence','CollapsedWoodenFence','CollapsedWhitePicketFence','CollapsedBambooFence','CollapsedBarredWall','CollapsedFenceAndGrass','RebarWallOverlay','RebarFloorOverlay','FrozenGroundOverlay','IcyWallOverlay','MeltedGroundOverlay','GrittedGroundOverlay','RustyFenceConcrete','TaintedFloor'}
-- Except "PowerStation", "Capacitor", "WaterPumpStation", "ElectricChair", "LogicBridge", "StatusLight", "PipeValve", "Light", "Sprinkler", "Drain", "WorkshopSaw", "WorkshopPress", "CarpenterTable", "PressurePad", "LaundryMachine",



sizeDict = {
	AccountingTable = {3, 1},
	Table = {4, 1},
	Bench = {4, 1},
	Bed = {1, 2},
	BunkBed = {1, 2},
	SuperiorBed = {1, 2},
	MedicalBed = {2, 2},
	ElectricChair = {2, 2},
	JailDoorXL = {3, 1},
	JailDoorLarge = {2, 1},
	WindowLarge = {2, 1},
	Cooker = {2, 1},
	Fridge = {2, 1},
	Sink = {3, 1},
	ServingTable = {5, 1},
	OfficeDesk = {2, 1},
	WaterBoiler = {2, 1},
	LargeTv = {3, 1},
	ShopFront = {2, 1},
	CctvMonitor = {3, 1},
	DoorControlSystem = {2, 1},
	WeaponRack = {2, 1},
	SofaChairDouble = {2, 1},
	SchoolDesk = {1, 2},
	MorgueSlab = {1, 2},
	PowerStation = {3, 3},
	WaterPumpStation = {3, 3},
	Servo = {1, 2},
	PoolTable = {3, 2},
	WorkshopSaw = {3, 1},
	WorkshopPress = {3, 1},
	CarpenterTable = {3, 2},
	VisitorTable = {3, 2},
	VisitorTableSecure = {2, 2},
	IroningBoard = {3, 1},
	SortingTable = {3, 1},
	LibraryBookshelf = {3, 1},
	ShopShelf = {3, 1},
	Altar = {3, 2},
	Pews = {4, 1},
	DogCrate = {1, 2},
	GuardTower = {2, 2},
	WaterBoiler = {2, 1},
}








local orDirs = {
	{0, 1},
	{-1, 0},
	{0, -1},
	{1, 0},
	{0, 1},
}

function rotateDirOf(o, orGroup)
	for i, xy in pairs( orDirs ) do

		if i > 4 then
			Game.DebugOut('Error: orGroup is invalid')
		else

			local dx = xy[1]
			local dy = xy[2]
			if dx == o[orGroup].x and dy == o[orGroup].y then
				local newOr = orDirs[i+1]
				-- print('from')
				-- print(o[orGroup].x)
				-- print(o[orGroup].y)
				-- print('to')
				-- print(newOr[1])
				-- print(newOr[2])
				-- If not `* 1.01`, sometimes the image will not change as rotating happens.
				if orGroup == 'Or' then
					o[orGroup].x = newOr[1]
					-- o[orGroup].y = newOr[2] * 2
					o[orGroup].y = newOr[2] * 1.01
				else
					o[orGroup].x = newOr[1] * 1.01
					o[orGroup].y = newOr[2]
				end
				return
			end

		end

	end
end

function offsetO(o)

	local rx = o.Pos.x - this.Pos.x
	local ry = o.Pos.y - this.Pos.y
	if rx == 0 and ry == 0 then return end

	local size = sizeDict[o.Type]
	if size == nil then
		print('No offset about such type:')
		print(o.Type)
		o.Pos.x = o.Pos.x + 0.0001 * o.Or.x
		return
	end
	if (size[1] + size[2]) % 2 == 0 then
		o.Pos.y = o.Pos.y + 0.0001 * o.Or.y
		return
	end

	print('offset')
	print(rx)
	print(ry)

	rx = rx * 2
	ry = ry * 2

	for i, xy in pairs( orDirs ) do

		if i > 4 then
			Game.DebugOut('Error: rx an ry is invalid')
		else

			local dx = xy[1]
			local dy = xy[2]
			if dx == rx and dy == ry then
				local newOr = orDirs[i+1]
				-- print('from')
				-- print(rx)
				-- print(ry)
				-- print('to')
				-- print(newOr[1])
				-- print(newOr[2])
				ry = newOr[2] / 2
				rx = newOr[1] / 2
				break
			end

		end

	end
	print(rx)
	print(ry)
	o.Pos.x = this.Pos.x + rx
	o.Pos.y = this.Pos.y + ry

	-- if o.Type == 'Pews' then
	-- 	if o.Or.x == 0 then
	-- 		-- vertical
	-- 		print('vertical')
	-- 		o.Pos.y = o.Pos.y + 0.5
	-- 		o.Pos.x = o.Pos.x + 0.5
	-- 	else
	-- 		o.Pos.y = o.Pos.y - 0.5
	-- 		o.Pos.x = o.Pos.x - 0.5
	-- 		-- o.Pos.y = o.Pos.y - 0.5
	-- 		-- o.Pos.x = o.Pos.x - 0.5
	-- 	end
	-- end
end

function rotateO(o)
	o.Or.x = math.min(o.Or.x, 1)
	o.Or.x = math.max(o.Or.x, -1)
	o.Or.y = math.min(o.Or.y, 1)
	o.Or.y = math.max(o.Or.y, -1)
	rotateDirOf(o, 'Or')
	offsetO(o)

	print('now-----')
	print(o.Or.x)
	print(o.Or.y)
	if o.OpenDir then
		rotateDirOf(o, 'OpenDir')
	end
	updateWall(o)
end

function rotateThose()

	for k, v in pairs(objTypes) do
		local os = this.GetNearbyObjects(v, 0.75)
		for o, distance in pairs( os ) do
			if o.Hidden then
			else
				rotateO(o)
				this.Sound("Guard", "Place") -- Fffoww
			end
		end
	end
end



function tryFindNewWall(o)
	-- print('tryFindNewWall')
	o.Walls.x = 0
	o.Walls.y = 0
	local dir = {}
	local cellOr = {}
	for i, xy in pairs( orDirs ) do

		if i > 4 then break end

		local dx = xy[1]
		local dy = xy[2]
		-- print(dx)
		-- print(dy)
		-- print('...')
		if dx == o.Walls.x and dy == o.Walls.y then
		else
			local cell = getCell(o.Pos.x + dx, o.Pos.y + dy)
			if wallTypeDict[cell.Mat] then
				-- print('NEW WALL!')
				-- print(dx)
				-- print(dy)
				o.Walls.x = dx
				o.Walls.y = dy
				-- dir = {
				-- 	x = dx,
				-- 	y = dy,
				-- }
				if dx == o.Or.x and dy == o.Or.y then
					print('o.Or.y')
					print(o.Or.y)
					-- cellOr = {
					-- 	x = dx,
					-- 	y = dy,
					-- }
					break
				end
			end
		end
	end
	-- if dir.x == nil then
	-- else
	-- end
end


function makeBooleanDict(t)
	local d = {}
	for k, v in pairs(t) do
		d[v] = true
	end
	return d
end

local AttachToWallTypes = {'Radio', 'Crib', 'Toilet', 'Table', 'ShowerHead', 'Bookshelf', 'OfficeDesk', 'FilingCabinet', 'MorgueSlab', 'PhoneBooth', 'Tv', 'Cctv', 'GuardLocker', 'SofaChairSingle', 'SofaChairDouble', 'DrinkMachine', 'ArcadeCabinet', 'Altar', 'Radiator',}
-- 'Bed', 'SuperiorBed', 'SchoolDesk', 'Sprinkler', 'WeaponRack',
local AttachToWallTypeDict = makeBooleanDict(AttachToWallTypes)

function updateWall(o)
	if not AttachToWallTypeDict[o.Type] then
		return
	end

	if o.Walls.x == 0 and o.Walls.y == 0 then
		tryFindNewWall(o)
	else
		local cellWall = getCell(o.Pos.x + o.Walls.x, o.Pos.y + o.Walls.y)
		-- print(cellWall.Mat)
		if not wallTypeDict[cellWall.Mat] then
			tryFindNewWall(o)
		end
	end
end

function getCell(x, y)
	return World.GetCell(math.floor(x), math.floor(y))
end


