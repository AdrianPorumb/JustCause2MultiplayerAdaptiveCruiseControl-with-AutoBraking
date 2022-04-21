
function chatbox(args)
	if args.text=="/cc" then if cruisecontrolisactive==false then cruisecontrolisactive=true				-- binary switch
	getcruisecontrolspeed=LocalPlayer:GetVehicle():GetLinearVelocity():Length() 
		else cruisecontrolisactive=false 
	return false end end end



function Inputthis()
if cruisecontrolisactive and IsValid(LocalPlayer) and IsValid(LocalPlayer:GetVehicle()) and LocalPlayer:GetVehicle():GetClass()==2 and LocalPlayer:GetSeat()==0 and Game:GetState() == GUIState.Game then 
	local getactualspeed=LocalPlayer:GetVehicle():GetLinearVelocity():Length()
	local speeddifference=getactualspeed/getcruisecontrolspeed
	local 	detection={}
	local	vpos=LocalPlayer:GetVehicle():GetCenterOfMass()
detection=Physics:Raycast((vpos),(LocalPlayer:GetVehicle():GetLinearVelocity()),0,(getactualspeed))
  		if speeddifference>1 and detection.entity==nil  then 						 -- nothing ahead
		Input:SetValue(40,ComputeInputforCruiseControlB(speeddifference) )			 -- braking					
		elseif detection.entity~=nil and detection.distance<getactualspeed then 	 -- something is ahead 		
		Input:SetValue(40,getactualspeed/detection.distance )
				else Input:SetValue(39,ComputeInputforCruiseControlA(speeddifference,getactualspeed,getcruisecontrolspeed))	end
	elseif cruisecontrolisactive and IsValid(LocalPlayer) and not IsValid(LocalPlayer:GetVehicle())  then 
			cruisecontrolisactive=false
			Input:Clear()
			end
	end
	
function ComputeInputforCruiseControlA(speeddifference,getactualspeed,getcruisecontrolspeed) 
local newspee=getcruisecontrolspeed-1--used to avoid anoying brake flashing 
if getactualspeed<newspee and speeddifference<0.5 then return 1-speeddifference 
elseif  getactualspeed<newspee and speeddifference>=0.5 then return speeddifference
else return 0.2
  end end


function ComputeInputforCruiseControlB(speeddifference)
 local result =speeddifference-1 
if result<1 then return result else return 1 end
end

Events:Subscribe("LocalPlayerChat",chatbox  )
Events:Subscribe("InputPoll",Inputthis  )
