-- CloneSpread
local flip

function look(who, types, cb, range, justOne)
	local count = 0
	if range == "max" then range = 9999 end
	for k, v in pairs(types) do
		local os = who.GetNearbyObjects(v, range)
		for o, distance in pairs( os ) do
			-- print(o.Type)
			count = count + 1
			if cb then
				cb(o)
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

local anchor
local rs

function setRoomSelector(o)
	if not o.discarded then
		rs = o
	end
end

function Create()
	anchor = Object.Spawn('Anchor', 0, 0)

	look(this, {'RoomSelector'}, setRoomSelector, 'max')
	if rs and not inRoom(this.Pos.x, this.Pos.y, rs) then
		-- print('clone...')
		trySpread()
		if World.CheatsEnabled and World.ImmediateObjects then
			this.Hidden = true
			this.Delete()
		end

	else
		this.Hidden = true
		this.Delete()
	end

	anchor.Delete()
	this.Delete()
end

local dest = {}
local rc = {}
function trySpread()
	dest.x = this.Pos.x
	dest.y = this.Pos.y
	rc.x = math.floor((dest.x - rs.l) / (rs.r - rs.l))
	rc.y = math.floor((dest.y - rs.t) / (rs.b - rs.t))
	if math.abs(rc.x) > math.abs(rc.y) then
		spread('x', 'y')
	elseif math.abs(rc.x) < math.abs(rc.y) then
		spread('y', 'x')
	else
		this.Delete()
	end
end

function spread(primary, secondary)
	local primaryStep
	local primaryStartPoint
	if primary == 'x' then
		primaryStep = rs.r - rs.l
		primaryStartPoint = rs.l
	else
		primaryStep = rs.b - rs.t
		primaryStartPoint = rs.t
	end

	local secondaryStartPoint
	if secondary == 'x' then
		secondaryStartPoint = rs.l
	else
		secondaryStartPoint = rs.t
	end


	local loop_to
	if rc[primary] > 0 then
		loop_to = rc[primary]
	else
		loop_to = -rc[primary]
		primaryStep = -primaryStep
	end

	for i = 1, loop_to do
		this.Pos[primary] = primaryStartPoint + i * primaryStep + 0.5
		this.Pos[secondary] = secondaryStartPoint + 0.5
		clone()
	end
end

function clone()
	local destLeft = this.Pos.x - 0.5
	local destTop = this.Pos.y - 0.5
	local tx
	local ty

	for sy = rs.t, rs.b do

		if flip == 'y' then
			ty = destTop + (rs.b - sy)
		else
			ty = destTop + (sy - rs.t )
		end

		for sx = rs.l, rs.r do
			if flip == 'x' then
				tx = destLeft + (rs.r - sx)
			else
				tx = destLeft + (sx - rs.l)
			end
			copyCell(sx, sy, tx, ty, flip)
		end

	end

end



local wallTypeDict = {ConcreteWall=true, BrickWall=true, BurntWall=true, Fence=true, PerimeterWall=true}

local objTypes = {'Toilet','ShowerHead','ShowerPillar','Drain','WoodDrain','BathroomSink','PersonalSink','SinkMirror','BathroomHandDryer','LaundryMachine','IroningBoard','IroningBoardShort','LaundryBasket','Light','WallLight','SolarLight','SolarWallLight','StreetLamp','FloodLight','SearchLight','AdvancedSearchLight','Chandelier','OrnateLantern','Lamp','LightGreen','LightRed','Radio','BoomBoxRoundhouse','Tv','LargeTv','CinemaScreen','CinemaProjector','ArcadeCabinet','PoolTable','TableTennis','TableFootball','Canvas','ChessTable','PlayMat','VisitorTable','PhoneBooth','VideoCallBooth','VisitorTableSecure','PetBird','Bookshelf','Blackboard','ComputerStation','ShortBookcase','ShortBookcase','Altar','Pews','PrayerMat','Fan','GangGraffiti','TattooRemovalMachine','WorkshopSaw','WorkshopPress','CarpenterTable','SortingTable','ShopFront','ShopCounter','ShopShelf','AccountingTable','Shed','BasicAutoGatherer','AdvancedAutoGatherer','AutoScythe','AutoHarvester','DripPipe','CropSprinkler','CompostBin','StorageShelf','PracticeSolarPanel','SoftPillow','Bed','Mattress','OldBed','BunkBed','CoffinBed','ComfyBed','SuperiorBed','Crib','CampBed','NettedBed','WoodenStool','WoodenTable','JungleBench','JungleTable','Table','Bench','SmallTable','SmallBench','OakTable','OakBench','SchoolDesk','FilingCabinet','OfficeDesk','ChestOfDrawers','SwivelChair','FancyDesk','OfficeChair','FilingCabinetFancy','OutdoorTable','Chair','ChairYellow','SofaChairSingle','SofaChairDouble','SofaChairBrown','SofaChairDoubleBrown','LeatherChair','LeatherSofa','OvalStaffTable','DeckChair','MetalStool','ParkBench','Bleachers','Window','WindowLarge','WoodenWindowSmall','WoodenWindowLarge','GlassWindow','GlassWindowLarge','WindowClassy','WindowClassyLarge','StainGlassWindow','WeightsBench','GymMat','DumbbellRack','Treadmill','PunchBag','TrainingDummy','TyreApparatus','FightRing','PullUpBars','KneeRaise','PushUpStones','BoxingRing','FirePit','TreeVines','TyreStack','DoorMat','BorderPlantA','BorderPlantB','BorderPlantC','Painting1','Painting2','Banner','ClimbingRope','CoatStand','MooseHead','Gravestone','WoodenBarrel','MetalBarrel','StoneWaterSpout','Fountain','GardenGnome','TopiaryBush','TopiaryBushBall','TopiaryBushWarden','TopiaryBushSwan','TopiaryBushDeer','TopiaryBushDog','TopiaryBushCat','TopiaryBushRex','OxStatue','PaperDragonHead','PaperDragonBody','PaperDragonTail','PaperLantern','CoupletBanner','PinkFlamingo','FlowerPlanterWateringCan','FlowerPlanterWellies','FlowerPlanterWheelbarrow','HayBale','SpiderWeb','JackOLantern','DecoratedTree','WoodenDockFloor','WallPanel','WallPanelWood','WallPanelStone','WallPanelCorner_A','WallPanelWoodCorner_A','WallPanelStoneCorner_A','WallPanelCorner_B','WallPanelWoodCorner_B','WallPanelStoneCorner_B','Footbridge','GrassBridge','FootbridgeSteel','FootbridgeB','FootbridgeSteelB','Bin','RecyclingBin','Plant','PlantCactus','Ivy','Bush','FernBush','Tree','BareTree','CactusTree','SpookyTree','PalmTree','SnowyConiferTree','WillowTree','SakuraTree','IndoorTreePlanter','FallenTree','FallenTreeBig','TreeStump','CropCarrotPlant','CropPotatoPlant','CropTomatoPlant','CropCabbagePlant','CropCornPlant','CropWheatPlant','CropBarleyPlant','CropAppleTree','CropOrangeTree','CropPeachTree','CropBananaTree','FlowerRoseBush','FlowerSunflower','FlowerMixedBegonias','FlowerHeatherBushes','FlowerHydrangeaPlant','CompostFertilizer','HighQualityFertilizer','BakerySign','GymSign','NoEntrySign','PhoneSign','RestaurantSign','VisitationSign','ArmourySign','LeftArrowSign','RightArrowSign','CanteenSign','InfirmarySign','ShowerSign','ToiletSign','SignNumber0','SignNumber1','SignNumber2','SignNumber3','SignNumber4','SignNumber5','SignNumber6','SignNumber7','SignNumber8','SignNumber9','SignLetterA','SignLetterB','SignLetterC','SignLetterD','SignLetterE','SignLetterF','SignLetterG','SignLetterH','SignLetterI','SignLetterJ','SignLetterK','SignLetterL','SignLetterM','SignLetterN','SignLetterO','SignLetterP','SignLetterQ','SignLetterR','SignLetterS','SignLetterT','SignLetterU','SignLetterV','SignLetterW','SignLetterX','SignLetterY','SignLetterZ','FireExtinguisher','FireAlarm','Sprinkler','MetalDetector','WeaponRack','GuardLocker','DogCrate','DogDoo','RobotDogDoo','DogBowl','GuardTower','BambooGuardTower','GuardPavilion','GuardPavilionCorner','BarbedWire','WindSock','PASystem','TrackingMonitor','Cctv','CameraPillar','CctvMonitor','CctvCamo','Servo','ServoProxy','DoorTimer','DoorControlSystem','PhoneMonitor','TargetSorter','GangSorter','WardenStatue','ScannerMonitor','ScannerMachine','CheckPoint','DistractionContraption','MedicalBed','MedicineCabinet','MedicalBox','MorgueSlab','FirstAidStation','MedicineCabinetPsych','RorschachTest','AnatomyModel','Flipboard','TherapyAnimalContainer','TherapyAnimal','HealthMonitor','ElectricChair','Cooker','Sink','Fridge','TallFridge','ServingTable','SmallServingTable','JungleServingTable','TrayDispenser','FoodTrayPack','DisplayCounter','CakeStand','DiningTableLarge','DiningTableSmall','DinerBooth','Oven','DoughMixer','DiningChair','CoffeeMachine','DrinkingFountain','WaterCooler','SnackMachine','DrinkMachine','PowerStation','Capacitor','PowerCapacitorMaxPlus','ElectricalCable','WeatherAntenna','WeatherMachine','LightningRod','HeavyDutyElectricalCable','TrainingElectricalCable','WillBeDamagedElectricalCable','DamagedElectricalCable','BackupGenerator','WaterPumpStation','WaterBoiler','PipeValve','PipeLarge','PipeSmall','PipeHotWater','Radiator','PipeSmallLagged','PipeValveLagged','PipeHotLagged','WaterStationLagged','WaterBoilerLagged','WindTurbine','SolarWindHybrid','SolarPanels','PowerExportMeter','Transformer','Battery','PressurePad','PowerSwitch','LogicCircuit','LogicBridge','StatusLight','Wire','TidyWires','ShowAllWires','HitmanMarker','TargetDirection','SightMarker','HitmanReward','HitmanFine','DeathFine','A48Clothes','FlammableUniform','FakeExtinguisher','Explosion','CheatPrisonerMisbehavior','RoomCellMarker','RoomSelector','CloneSimple','CloneFlipX','CloneFlipY','CloneSpreadAligned','CloneSpreadAngled','MoveRoom','ClearSelector','MoveObjectMarker','MoveObject','RotateObject','LightHere','AttentionToPrisoner','AttentionMarker','TimeWarpNeedModifier','PCommand','CCommand','SwapOffice','SwapOfficeMarker','TimedCaller','MusterGuards','SearchToilets','Water','WaterWalkable','WaterShallow','WaterLarge','WaterBed','MurkyWater','MurkyWaterLarge','MurkyWaterShallow','MurkyWaterWalkable','MurkyWaterBed','SteppingStone','SteppingStoneLillyPad','SteppingStoneIceBlock','SteppingStonePallet','Dirt','Mud','NewMud','Sand','Grass','GrassCornerFloor','GrassCornerFloor1','GrassCornerFloor2','GrassCornerFloor3','FieldGrass','LongGrass','FlowerField','GrassStones','Sandstone','PavingStone','Gravel','Stone','JunglePath','RunningTrack','Road','RoadMarkings','RoadMarkingsLeft','RoadMarkingsRight','RoadCrossing','RoadCrossingLeft','RoadCrossingRight','Snow','LunarFloor','ConcreteFloor','YellowStraightLineTiles','YellowCornerLineTiles','ConcreteTiles','ConcreteMossFlooring','ConcreteLeavesFlooring','WoodenFloor','DarkWoodFloor','LaminateFlooringFR','BambooFloor','MetalFloor','NewIronFloor','NewCargoFloor','SolacoFloor','GrateFloor','Roof','BurntFloor','ReclaimedBrickFloor','ReclaimedRubberFloor','CeramicFloor','WhiteTiles','MosaicFloor','FancyTiles','NewCheckeredFloor','MarbleTiles','HexagonalTiles','TriangularTiles','LimestoneFloor','WeatheredStoneFlooring','BlueCarpet','BrownCarpet','RedCarpet','CarpetFR','ColouredStoneTiles','PaddedFloor','NewHedgeWall','HayBailWall','BambooFence','WoodenFence','WhitePicketFence','Fence','FenceAndGrass','NewBarredWall','RustyWall','SlumWall','DerelictWall','OvergrownWall','DecayedWall','ConcreteWall','WallMinSec','WallMedSec','WallMaxSec','WallSuperMaxSec','WallDeathRowSec','WallInsaneSec','WallProtective','BrickWall','NewBBlockWall','NewTiledWall','ArtDecoWall','OrientalWall','YutaniWall','ReclaimedWoodWall','BottleWall','GardenWall','BlueWall','BurgundyWall','CushionedWall','GreenWall','PerimeterWall','CliffEdge','FenceWall','CageFence','GlassWall','ElectrifiedFence','BurntWall','RustyFenceGrass','RustyFenceLongGrass','RoadGate','RoadBarrier','Door','DoubleDoor','BambooDoor','SaloonDoor','BarnDoor','WhitePicketGate','Gate','DoubleGate','CageGate','JailBars','KeycardDoor','KeycardDoorLarge','FenceGateStandard','FenceGateStaff','FenceGateGuard','FenceGateVisitor','SecretDoor','StaffDoor','StaffDoorBlue','StaffDoorOrange','VisitorDoor','DoubleStaffDoor','DoubleStaffDoorBlue','DoubleStaffDoorOrange','DoubleVisitorDoor','JailDoor','JailDoorGrey','JailDoorYellow','JailDoorOrange','JailDoorRed','JailDoorDarkRed','JailDoorBlack','JailDoorWhite','JailDoorRusty','JailDoorLarge','JailDoorLargeGrey','JailDoorLargeYellow','JailDoorLargeOrange','JailDoorLargeRed','JailDoorLargeDarkRed','JailDoorLargeBlack','JailDoorLargeWhite','JailDoorLargeRusty','JailDoorXL','JailDoorGreyXL','JailDoorOrangeXL','JailDoorRedXL','JailDoorDarkRedXL','JailDoorBlackXL','JailDoorYellowXL','JailDoorWhiteXL','SolitaryDoor','SecureDoor','RemoteDoor','RemoteDoorYellow','RemoteDoorOrange','RemoteDoorRed','RemoteDoorBlack','RemoteDoorWhite','RemoteDoorMaroon','CollapsedWall','CollapsedFence','CollapsedWoodenFence','CollapsedWhitePicketFence','CollapsedBambooFence','CollapsedBarredWall','CollapsedFenceAndGrass','RebarWallOverlay','RebarFloorOverlay','FrozenGroundOverlay','IcyWallOverlay','MeltedGroundOverlay','GrittedGroundOverlay','RustyFenceConcrete','TaintedFloor'}



function copyCell(sx, sy, tx, ty)
	local cellSource = World.GetCell(sx, sy)
	local cellTarget = World.GetCell(tx, ty)
	if not wallTypeDict[cellTarget.Mat] and cellTarget.Mat ~= cellSource.Mat then

		if World.CheatsEnabled and World.ImmediateObjects then
			cellTarget.Mat = cellSource.Mat
		else
			local cc = Object.Spawn('CCommand', tx, ty)
			cc.mat_type = cellSource.Mat
			cc.mat_type_old = cellTarget.Mat
			cellTarget.Mat = cellSource.Mat
		end

	end
	local new
	local dx
	local dy
	for k, v in pairs(objTypes) do
		anchor.Pos.x = sx+0.5
		anchor.Pos.y = sy+0.5
		local os = anchor.GetNearbyObjects(v, 0.75)
		for o, distance in pairs( os ) do
			-- print(o.Type)
			if o.Pos.x == sx + 1 or o.Pos.y == sy + 1 then
				-- Not this cell
				-- print('Not this cell')
			else
				if o.Pos.x == sx and flip == 'x' then
					dx = 1
				else
					dx = 0
				end
				if o.Pos.y == sy and flip == 'y' then
					dy = 1
				else
					dy = 0
				end

				local new_x = o.Pos.x + tx - sx + dx
				local new_y = o.Pos.y + ty - sy + dy
				anchor.Pos.x = new_x
				anchor.Pos.y = new_y

				if look(anchor, {o.Type}, nil, 0.1, true) then
				else
					new = Object.Spawn(o.Type, new_x, new_y)

					if flip == 'x' then
						new.Or.x = -o.Or.x
						new.Walls.x = -o.Walls.x
					else
						new.Or.x = o.Or.x
						new.Walls.x = o.Walls.x
					end

					if flip == 'y' then
						new.Or.y = -o.Or.y
						new.Walls.y = -o.Walls.y
					else
						new.Or.y = o.Or.y
						new.Walls.y = o.Walls.y
					end

					if o.OpenDir then
						new.OpenDir.x = o.OpenDir.x
						new.OpenDir.y = o.OpenDir.y
					end

					if World.CheatsEnabled and World.ImmediateObjects then
					else
						local pc = Object.Spawn('PCommand', new.Pos.x, new.Pos.y)
						pc.obj_type = new.Type
						pc.Or.x = new.Or.x
						pc.Or.y = new.Or.y
						new.Delete()
					end
				end

			end

		end
	end
end

function inRoom(x, y, room)
	x = math.floor(x)
	y = math.floor(y)
	if x >= room.l and x < room.r and y >= room.t and y < room.b then
		return true
	else
		return false
	end
end
