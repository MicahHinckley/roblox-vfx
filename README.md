# roblox-vfx

For now, you can only create a 3D particle emitter with the VFX module.

```lua
local VFX = require(...)

local props = {

}

VFX.CreateEmitter(props)
```

This will not work however because at the very minimum, you need an actor prop!

```lua
local props = {
  Actor = Instance.new("Part");
}
```

Other properties include:

``Position (Vector3): Position of the emitter``

``Rate (Number): How many seconds it takes to spawn a particle``

``Speed (Number): The speed in studs per second that the particle travels in its direction``

``Direction (Vector3): The direction that the particles travel in``

``RotationalVelocity (Vector3): The rotational velocity which gets converted to CFrame.Angles()``

``Lifetime (Number): How long each particle stays alive in seconds``

``ActorProps (Dictionary): Used to change the particle's actor on creation. Example:``
```lua
props.ActorProps = {
  Size = Vector3.new(1, 2, 1);
}
```

``Motors (Dictionary): Used to modify the particle's actor's properties during animation. Example:``
```lua
local function Lerp(initial, finish, delta)
  return (1 - delta) * initial + delta * final
end

props.Motors = {
  Transparency = function(delta, particle)
    return Lerp(0, 1, delta)
  end;
}
```

# Tips:
All props can be assigned to a function. This function should return a value of the require type. This function is ran for each particle at it's creation. This allows for custom randomization of properties. Example:
```lua
local props = {
  Size = function()
    return Vector3.new(math.random(1, 3), math.random(1, 3), math.random(1, 3))
  end
}
```

# Example
```lua
--< Services >--
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--< Modules >--
local VFX = require(ReplicatedStorage.VFX)

--< Variables >--
local Part = Instance.new("Part")
Part.Material = Enum.Material.SmoothPlastic
Part.Size = Vector3.new(1, 1, 1)
Part.CanCollide = false
Part.Anchored = true
Part.CastShadow = false
Part.BackSurface = Enum.SurfaceType.SmoothNoOutlines
Part.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
Part.FrontSurface = Enum.SurfaceType.SmoothNoOutlines
Part.LeftSurface = Enum.SurfaceType.SmoothNoOutlines
Part.RightSurface = Enum.SurfaceType.SmoothNoOutlines
Part.TopSurface = Enum.SurfaceType.SmoothNoOutlines

--< Functions >--
local function Lerp(initial, final, delta)
	return (1 - delta) * initial + delta * final
end

--< Start >--
VFX.CreateEmitter({
	Actor = Part;
	Position = Vector3.new(0, 10, 0);
	Rate = 0.1;
	Speed = 4;
	
	Direction = function()
		return Vector3.new(math.random(-5, 5)/10, math.random(5, 10)/10, math.random(0, 5)/5)
	end;
	
	RotationalVelocity = function()
		return Vector3.new(math.random(-2, 2), math.random(-2, 2), math.random(2, 2))
	end;
	
	Lifetime = 2;
	
	ActorProps = {
		Orientation = function()
			return Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
		end;
		
		Color = function()
			return Color3.fromRGB(255, math.random(100, 200), 0)
		end;
		
		Size = function()
			local S = math.random(5, 10)/20
			return Vector3.new(S, S, S)
		end;
	};
	
	Motors = {
		Size = function(delta, particle)
			return Vector3.new(Lerp(particle.ActorProps.Size.X, 0, delta), Lerp(particle.ActorProps.Size.Y, 0, delta), Lerp(particle.ActorProps.Size.Z, 0, delta))
		end;
		
		Transparency = function(delta)
			return Lerp(0, 0.75, delta)
		end;
	};
})
```
