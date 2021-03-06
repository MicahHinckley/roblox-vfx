--< Variables >--
local Part = Instance.new("Part")
Part.Material = Enum.Material.SmoothPlastic
Part.Color = Color3.fromRGB(0, 0, 0)
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

--< Emitter >--
return function(describe)
    describe("Embers", {
        Actor = Part;
        Position = Vector3.new(0, 5, 0);
        Rate = 10;
        Acceleration = Vector3.new(0, -1, 0);
    
        Velocity = function()
            return Vector3.new(math.random(-5, 5)/2.5, math.random(5, 10), math.random(-5, 5)/2.5)
        end;
        
        RotationalVelocity = function()
            return Vector3.new(math.random(-4, 4), math.random(-4, 4), math.random(4, 4))
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
    }, 30)
end